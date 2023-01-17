//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-08.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell
{
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("Unsupported")
    }
    
    private func setUpConstraints(){
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // Configures the view to the view model
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel)
    {
        viewModel.registerForData {data in
            print(data.name)
            print(data.air_date)
            print(data.episode)
        }
        viewModel.fetchEpisode()
    }
    
}
