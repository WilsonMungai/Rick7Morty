//
//  RMCharacterDetail.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-01.
//

import UIKit

///  View for single character info
final class RMCharacterDetailView: UIView
{
    private var collectionView: UICollectionView?
    
    // Loading spinner
    private let spinner: UIActivityIndicatorView =
    {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        // A value that determines wheteher the view will be auto translated into auto layout contraints
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPurple
        let collectionView = createCollectionView()
        self.collectionView  = collectionView
        addSubviews(collectionView, spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints()
    {
        // Unwrap collection view since its nullable in the global scope
        guard let collectionView = collectionView else{
            return
        }
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
           collectionView.topAnchor.constraint(equalTo: topAnchor),
           collectionView.leftAnchor.constraint(equalTo: leftAnchor),
           collectionView.rightAnchor.constraint(equalTo: rightAnchor),
           collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createCollectionView() -> UICollectionView
    {
        // Creates a composition layout
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell, forCellWithReuseIdentifier: "cell")
        return collectionView
    }
    
    private func createSection(for: sectionIndex: Int) -> NSCollectionLayoutSection
    {
        
    }
}
