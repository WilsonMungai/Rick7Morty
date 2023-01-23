//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-08.
//

import UIKit

// Sets up the Episode View layout
final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell
{
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    private let seasonLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        setUpLayer()
        contentView.addSubviews(seasonLable, nameLabel, airDateLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("Unsupported")
    }
    
    // Content view setup
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
    }
    
    // View constraints
    private func setUpConstraints(){
        
        NSLayoutConstraint.activate([
            seasonLable.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            seasonLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),
            seasonLable.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: seasonLable.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            airDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Resets the view
        seasonLable.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
        
    }
    
    // Configures the view to the view model
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel)
    {
        viewModel.registerForData {[weak self] data in
            // Already on the main Queue
//            print(data.name)
//            print(data.air_date)
//            print(data.episode)
            self?.nameLabel.text = data.name
            self?.seasonLable.text = "Episode " + data.episode
            self?.airDateLabel.text = "This was aired on " + data.air_date
        }
        viewModel.fetchEpisode()
        contentView.layer.borderColor = viewModel.borderColor.cgColor
    }
    
}
