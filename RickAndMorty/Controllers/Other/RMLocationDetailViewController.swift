//
//  RMLocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-03-05.
//

import UIKit

class RMLocationDetailViewController: UIViewController, RMLocationDetailViewViewModelDelegate, RMLocationDetailViewDelegate {
    
    private var viewModel: RMLocationDetailViewViewModel
    
    private let detailView = RickAndMorty.RMLocationDetailView()
    
    // MARK: - Init
    init(location: RMLocation?) {
        let url = URL(string: location!.url)
        self.viewModel = RMLocationDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        addConstraints()
        detailView.delegate = self
        title = "Location"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        viewModel.delegate = self
        viewModel.fetchLocationData()
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func didTapShare() {
        
    }
    
    // MARK: - View Delegate
    func RMLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter) {
        func RMEpisodeDetailView(
            _ detailView: RMLocationDetailView,
            didSelect character: RMCharacter
        ) {
            let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
            vc.title = character.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - View Model delegate
    func didFetchLocationDtaials() {
        detailView.configure(with: viewModel)
    }
}
