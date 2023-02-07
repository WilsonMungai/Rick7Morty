//
//  RMSearchViewViewController.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-23.
//

import UIKit

/// Deals with search activity
final class RMSearchViewViewController: UIViewController {

    struct Config {
        enum `Type` {
            case character
            case episode
            case location
        }
        
        let type: `Type`
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
    }
}
