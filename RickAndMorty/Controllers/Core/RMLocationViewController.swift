//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-27.
//

import UIKit

/// Controller to show and search for locations
final class RMLocationViewController: UIViewController
{
    private let primaryView = RMLocationView()
    
    private let viewModel = RMLocationViewModel()
    
    
    // MARK: - Lifecycle functions
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.addSubview(primaryView)
        view.backgroundColor = .systemBackground
        addSeacrchButton()
        title = "Location"
        addConstraint()
    }
    
    // Search Bar Button item
    private func addSeacrchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
        primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),])
    }
    
    @objc private func didTapSearch() {
        
    }
}
