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
            for character in characters
            {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image))
                    cellViewModels.append(viewModel)
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
    public func fetchAdditionalCharacters()
    {
        isLoadingMoreCharacters = true
        // Fetch more characters
        
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
        guard shouldShowLoadMoreIndicator, !isLoadingMoreCharacters
        else
        {
          return
        }
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        /* Check whether we are at the bottom by checking the offset,totalContentHeight & totalScrollViewFixedHeight
         * 100 is the height of the footer where the spinner is located, 20 is just an addition buffer
         */
        if offset >= (totalContentHeight-totalScrollViewFixedHeight-120)
        {
            fetchAdditionalCharacters()
//            print("Should start fetching more")
        }
        
//        print("Offset: \(offset)")
//        print("totalContentHeight: \(totalContentHeight)")
//        print("totalScrollViewFixedHeight: \(totalScrollViewFixedHeight)")
    }
}
