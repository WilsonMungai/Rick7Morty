//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-01.
//

import UIKit

/// Controller to show details about a single character
class RMCharacterDetailViewController: UIViewController
{
    // Instance of the RMCharacterDetailViewViewModel
    private let viewModel: RMCharacterDetailViewViewModel
    
    init(viewModel: RMCharacterDetailViewViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifecycle function
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
}
