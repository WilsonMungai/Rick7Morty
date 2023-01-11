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

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let iconeImageView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
//        icon.image = UIImage(systemName: "globe.europe.africa.fill")
        // Prevesnts the image from being distorted
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(valueLabel, titleContainerView, iconeImageView)
        titleContainerView.addSubview(titleLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("Unsupported")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            // The height of the label is 0.33 the height of the contentView
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            titleLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            valueLabel.leftAnchor.constraint(equalTo: iconeImageView.leftAnchor, constant: 40),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10 ),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor),
            
            
            iconeImageView.heightAnchor.constraint(equalToConstant: 30),
            iconeImageView.widthAnchor.constraint(equalToConstant: 30),
            iconeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            iconeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.text = nil
        iconeImageView.image = nil
        iconeImageView.tintColor = .label
        titleLabel.textColor = .label
        
    }
    
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel)
    {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconeImageView.image = viewModel.iconImage
        iconeImageView.tintColor = viewModel.tintColor
        titleLabel.textColor = viewModel.tintColor
    }
}
