//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-17.
//

import UIKit

/// Vc to show episode detail view controller
class RMEpisodeDetailViewController: UIViewController {

    private var viewModel: RMEpisodeDetailViewViewModel
    
    // MARK: - Init
    init(url: URL?) {
        self.viewModel = .init(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemGreen
    }

}
