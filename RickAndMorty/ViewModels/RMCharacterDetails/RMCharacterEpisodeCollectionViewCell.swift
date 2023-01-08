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
    
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel)
    {
        
    }
    
}
