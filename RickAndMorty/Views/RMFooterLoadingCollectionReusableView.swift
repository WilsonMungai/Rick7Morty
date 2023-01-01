//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-01.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView
{
    static let identifier = "RMFooterLoadingCollectionReusableView"
    
    // Loading spinner
    private let spinner: UIActivityIndicatorView =
    {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(spinner)
        addConstraints()
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
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),])
    }
    
    public func startAnimating()
    {
        spinner.startAnimating()
    }
}
