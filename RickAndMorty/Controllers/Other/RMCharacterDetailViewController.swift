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
    private let detailView: RMCharacterDetailView
    
    // MARK: - Initializer
    // Instance of the RMCharacterDetailViewViewModel
    private let viewModel: RMCharacterDetailViewViewModel
    
    init(viewModel: RMCharacterDetailViewViewModel)
    {
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
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
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
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

    // MARK: - For collection view

extension RMCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType
        {
            // Photo cell
        case .photo(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier,
                for: indexPath) as?  RMCharacterPhotoCollectionViewCell
            else{
                fatalError()
            }
            cell.configure(with: viewModels)
            return cell
            
            // Information cells
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier,
                for: indexPath) as?  RMCharacterInfoCollectionViewCell
            else{
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
            
            // Episode cells
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier,
                for: indexPath) as?  RMCharacterEpisodeCollectionViewCell
            else{
                fatalError()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
        
        // Hard coded background colors
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .systemPink
//        if indexPath.section == 0
//        {
//            cell.backgroundColor = .systemPink
//        }
//        else if indexPath.section == 1
//        {
//            cell.backgroundColor = .systemPurple
//        }
//        else
//        {
//            cell.backgroundColor = .systemRed
//        }
//        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let sectionType = viewModel.sections[section]
        switch sectionType
        {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
        
        // Hard coded cells
        //        switch section {
        //        case 0:
        //            return 1
        //        case 1:
        //            return 8
        //        case 2:
        //            return 20
        //        default:
        //            return 1
        //        }
        //    }
    }
}
