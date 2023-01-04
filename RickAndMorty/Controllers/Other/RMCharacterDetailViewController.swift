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
    private let detailView = RMCharacterDetailView()
    
    // MARK: - Initializer
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
        view.addSubview(detailView)
        addConstraints()
        // Share bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare))
    }
    
    // View constraints
    private func addConstraints()
    {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // Share bar button
    @objc
    private func didTapShare()
    {
      // Share character information
    }
}
