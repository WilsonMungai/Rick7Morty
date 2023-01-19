//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-28.
//

import UIKit

// Notifies when an epiosde is selected
protocol RMEpisodeListViewDelegate: AnyObject
{
    func rmEpisodeListView(_ characterListView: RMEpisodeListView,
                             didSelectEpiosde epiosde: RMEpisodes)
}

/// View that handles showing list of episodes loader
final class RMEpisodeListView: UIView
{
    public weak var delegate: RMEpisodeListViewDelegate?
    
    // Instance of the RMCharacterListViewViewModel
    private let viewModel = RMEpisodeListViewViewModel()

    // Loading spinner
    private let spinner: UIActivityIndicatorView =
    {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // Collection view to display a list of items
    private let collectionView: UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        // Registering the cell
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier)
        // Registering a footer at the bottom of the collection view
        collectionView.register(RMFooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(collectionView, spinner)
        addConstraints()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchEpisodes()
        setUpCollectionView()
    }

    required init?(coder: NSCoder)
    {
        fatalError("Unsupported")
    }
    
    private func addConstraints()
    {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
           collectionView.topAnchor.constraint(equalTo: topAnchor),
           collectionView.leftAnchor.constraint(equalTo: leftAnchor),
           collectionView.rightAnchor.constraint(equalTo: rightAnchor),
           collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setUpCollectionView()
    {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        
        // Hard coded spinner settings and collection view
//        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute:
//        {
//            self.spinner.stopAnimating()
//
//            self.collectionView.isHidden = false
//
//            UIView.animate(withDuration: 0.4)
//            {
//                self.collectionView.alpha = 1
//            }
//        })
    }
}

/*
 Instance of the RMCharacterListViewViewModelDelegate protocol which notifies the character view controller to load the initial characters
 */
extension RMEpisodeListView: RMEpisodeListViewViewModelDelegate
{
    func didLoadInitialEpisodes() {
        collectionView.reloadData()
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData() // Only reloads for the initial view
        UIView.animate(withDuration: 0.4)
        {
            self.collectionView.alpha = 1
        }
        
    }
    
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates
        {
            
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    func didSelectEpisodes(_ episode: RMEpisodes) {
        delegate?.rmEpisodeListView(self, didSelectEpiosde: episode)
    }
}


