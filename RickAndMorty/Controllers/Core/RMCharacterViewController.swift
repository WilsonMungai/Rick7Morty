//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-27.
//

import UIKit

/// Controller to show and search for characters
final class RMCharacterViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Supports both light mode and dark mode
        view.backgroundColor = .systemBackground
        title = "Characters"
    }
    

}
