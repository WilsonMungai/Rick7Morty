//
//  RMEpisodeInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-27.
//

import UIKit

final class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMEpisodeInfoCollectionViewCell"
    
    private let titlelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(titlelLabel, valueLabel)
        setUpLayer()
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titlelLabel.text = nil
        valueLabel.text = nil
    }
    private func setUpLayer(){
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            titlelLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  4),
            titlelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:  10),
            titlelLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -4),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  4),
            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:  -10),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -4),
            
            titlelLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47),
            valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47)
        ])
        
        titlelLabel.backgroundColor = .red
        titlelLabel.backgroundColor = .orange
    }
    
    func configure(with viewModel: RMEpisodeInfoCollectionViewCellViewModel) {
        titlelLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
