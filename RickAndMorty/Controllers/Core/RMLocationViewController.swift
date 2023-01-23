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

    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSeacrchButton()
        title = "Location"
    }
    
    // Search Bar Button item
    private func addSeacrchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }
}
