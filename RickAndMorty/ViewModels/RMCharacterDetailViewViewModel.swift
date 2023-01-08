//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-01.
//

import Foundation
import UIKit

final class RMCharacterDetailViewViewModel
{
    private let character: RMCharacter
    
    // enum section types to hold the different character detail information
    enum SectionType: CaseIterable
    {
        case photo
        case information
        case episodes
    }
    
    // MARK: - Init
    // A collection of values of SectionType
    public let sections = SectionType.allCases
    
    // Passing the character
    init (character: RMCharacter)
    {
        self.character = character
    }
    
    private var requestUrl:URL?
    {
        return URL(string: character.url)
    }
    
    public var title: String
    {
        character.name.uppercased()
    }
    
    // MARK: - Character details Layouts
    
    // Character photo layout section
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection
    {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    // Character information layout section
    public func createInformationSectionLayout() -> NSCollectionLayoutSection
    {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                               heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    // Character episode layout section
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection
    {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        // The section will scroll in relation to the main layout axis
        // paging method snaps the next page into place, continuous method scrolling is non stop
        section.orthogonalScrollingBehavior = .paging
        return section
    }
}
