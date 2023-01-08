//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-08.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell
{
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell"

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
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
    
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel)
    {
        
    }
}
