//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-28.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject
{
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    func didSelectCharacter(_ character: RMCharacter)
}

/// View model to handle character list view logic
final class RMCharacterListViewViewModel: NSObject
{
    /*
     Instance of the protocol RMCharacterListViewViewModelDelegate
     It is weak coz we dont want it to retain cyclical memory pointer leak memory
     */
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var characters: [RMCharacter] = []
    {
        didSet
        {
            // Assuming every character has a unique name, then the view model should not fetch characters with names that have already been fecthed
            for character in characters
//            where !cellViewModels.contains(where: { $0.characterName == character.name })
            {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image))
                
                // If this view model doesnt contain the created view model then and only then should it be insterd
                if !cellViewModels.contains(viewModel)
                {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    // Instance of RMCharacterCollectionViewCellViewModel class
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    // Instance of the info property in RMGetAllCharactersResponse strucct
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    /// Fetch initial set of characters (20 the initial number)
    // Function to fetch the characters
    public func fetchCharacters()
    {
        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMGetAllCharactersResponse.self)
        {
            [weak self] result in
            switch result
            {
            case.success(let responseModel):
                
                // Collection of results that we have
                let results = responseModel.results
                
                // Info data that we get from the api
                let info = responseModel.info
                
                self?.characters = results
                self?.apiInfo = info
                
                // We do this on the main thread since it triggers updates on the view
                DispatchQueue.main.async
                {
                    self?.delegate?.didLoadInitialCharacters()
                }
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional characters are needed
    public func fetchAdditionalCharacters(url: URL)
    {
        // Fetch more characters
        guard !isLoadingMoreCharacters
        else
        {
            return
        }
        isLoadingMoreCharacters = true
    
        guard let request = RMRequest(url: url)
        else
        {
            // Dont load more characters if no request was made
            isLoadingMoreCharacters = false
            return
        }
        RMService.shared.execute(request,expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            guard let strongSelf = self
            else
            {
                return
            }
            
            switch result
            {
            case.success(let responseModel):
                // Fetches more characters
                let moreResults = responseModel.results
                // Info data that we get from the api
                let info = responseModel.info
                strongSelf.apiInfo = info
                
                // Getting the count of the new fetched characters
                let originalCount = strongSelf.characters.count
                let newCount  = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indeXPathToAdd:[IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                // Adds the number of characters
                strongSelf.characters.append(contentsOf: moreResults)
            
                // We do this on the main thread since it triggers updates on the view
                DispatchQueue.main.async
                {
                    strongSelf.delegate?.didLoadMoreCharacters(
                        with:indeXPathToAdd)
                    
                    strongSelf.isLoadingMoreCharacters = false
                }
            case.failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreCharacters = false
            }
        }
        
    }
    
    public var shouldShowLoadMoreIndicator: Bool
    {
        return apiInfo?.next != nil
    }
}

// MARK: - Collection view implementation
// Extension of the class
extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    // Returns number of characters fetched in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return cellViewModels.count
    }
    
    // Reuses the cells to load in characters that have been fetcehd
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath
        )as? RMCharacterCollectionViewCell
        else
        {
            fatalError("Unsupported Cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        
        return cell
        
        //        let viewModel = RMCharacterCollectionViewCellViewModel(
        //            characterName: "Wilson",
        //            characterStatus: .alive,
        //            characterImageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        //
        //        cell.configure(with: viewModel)
    }
    
    // Asks your data source object to provide a supplementary view to display in the collection view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        guard kind == UICollectionView.elementKindSectionFooter,
              
                let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                    for: indexPath) as? RMFooterLoadingCollectionReusableView
                else
                {
                fatalError("Unsupported")
                }
        footer.startAnimating()
        return footer
    }
    
    // Speicfy the size of the footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        guard shouldShowLoadMoreIndicator else{
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    // Sets the size of the collection view cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width:width,
            height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // Unhighlight/deselect the selected item
        collectionView.deselectItem(at: indexPath, animated: true)
        
        // Notifies which character was actually selected
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

// MARK: - ScrollView

extension RMCharacterListViewViewModel: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        // isLoadingMoreCharacters ensures that we are loading the characters only once and not n times
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              // If the view is not empty then we are stil loading data
              !cellViewModels.isEmpty,
              let  nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString)
        else
        {
            return
        }
        
        // Timer to cause a delay action
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {[weak self] t in
            
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            /* Check whether we are at the bottom by checking the offset,totalContentHeight & totalScrollViewFixedHeight
             * 100 is the height of the footer where the spinner is located, 20 is just an addition buffer
             */
            if offset >= (totalContentHeight-totalScrollViewFixedHeight-120)
            {
                self?.fetchAdditionalCharacters(url: url)
            }
            // Stops the timer from firing it self again
            t.invalidate()
        }
        
        
//        let offset = scrollView.contentOffset.y
//        let totalContentHeight = scrollView.contentSize.height
//        let totalScrollViewFixedHeight = scrollView.frame.size.height
//
//        /* Check whether we are at the bottom by checking the offset,totalContentHeight & totalScrollViewFixedHeight
//         * 100 is the height of the footer where the spinner is located, 20 is just an addition buffer
//         */
//        if offset >= (totalContentHeight-totalScrollViewFixedHeight-120)
//        {
//            fetchAdditionalCharacters(url: url)
////            print("Should start fetching more")
//        }
        
//        print("Offset: \(offset)")
//        print("totalContentHeight: \(totalContentHeight)")
//        print("totalScrollViewFixedHeight: \(totalScrollViewFixedHeight)")
    }
}
