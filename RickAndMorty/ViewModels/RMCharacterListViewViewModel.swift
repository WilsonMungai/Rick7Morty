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

final class RMCharacterListViewViewModel: NSObject
{
    /*
     Instance of the protocol RMCharacterListViewViewModelDelegate
     It is weak coz we dont want it to retain cyclical memory pointer leak memory
     */
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
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
    
    // Function to fetch the characters
    func fetchCharacters()
    {
        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMGetAllCharactersResponse.self)
        { [weak self] result in
            switch result
            {
            case.success(let responseModel):
                // Collection of results that we have
                let results = responseModel.results
                self?.characters = results
                // We do this on the main thread since it triggers updates on the view
                DispatchQueue.main.async{
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

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
