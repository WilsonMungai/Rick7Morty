//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-27.
//

import UIKit

/// Controller to show and search for episodes
final class RMEpisodeViewController: UIViewController, RMEpisodeListViewDelegate {
    // instance of episode list view class
    private let episodeListView = RMEpisodeListView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Supports both light mode and dark mode
        view.backgroundColor = .systemBackground
        title = "Episodes"
        setUpView()
        addSeacrchButton()
    }
    
    // Search Bar Button item
    private func addSeacrchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }
    
    private func setUpView()
    {
        // Makes the view a delegate of the characterListView class
        episodeListView.delegate = self
        
        view.addSubview(episodeListView)
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - RMEpisodeListViewDelegate
    // Delegate implementation
    // Opens detail controller for the episode
    func rmEpisodeListView(_ characterListView: RMEpisodeListView, didSelectEpiosde epiosde: RMEpisodes) {
        let detailVC = RMEpisodeDetailViewController(url: URL(string: epiosde.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
