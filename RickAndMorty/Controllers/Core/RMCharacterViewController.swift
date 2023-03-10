//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-27.
//

import UIKit

/// Controller to show and search for characters
final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate
{
    // instance of character list view class
    private let characterListView = RMCharacterListView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Supports both light mode and dark mode
        view.backgroundColor = .systemBackground
        title = "Characters"
        addSeacrchButton()
        setUpView()
    }
    
    private func setUpView()
    {
        // Makes the view a delegate of the characterListView class
        characterListView.delegate = self
        
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // Search Bar Button item
    private func addSeacrchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    // Links the search button to the search view controller and speicfies the character type to search for characters
    @objc private func didTapSearch() {
        let vc = RMSearchViewViewController(config:RMSearchViewViewController.Config(type: .character))
        // Disables the large title from being displayed
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - RMCharacterListViewDelegate
    
    // Delegate implementation
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter)
    {
        /*Open detail controller for the character selected
         We get the character value from the rmCharacterListView function paramater, that is the character that was selected
         */
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
