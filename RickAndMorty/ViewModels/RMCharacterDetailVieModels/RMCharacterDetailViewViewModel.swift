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
    
    // Exposes the epidoes the character was featured in
    public var epidoses: [String]{
        character.episode
    }
    
    // enum section types to hold the different character detail information
    enum SectionType
    {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        
        case information(viewModel: [RMCharacterInfoCollectionViewCellViewModel])
        
        case episodes(viewModel: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    
    // MARK: - Init
    // A collection of values of SectionType
    public var sections: [SectionType] = []
    
    // Passing the character
    init (character: RMCharacter)
    {
        self.character = character
        setUpSections()
    }
    
//    let id: Int
//    let name: String
//    let status: RMCharacterStatus
//    let species: String
//    let type: String
//    let gender: RMCharacterGender
//    let origin: RMOrigin
//    let location: RMSingleLocation
//    let image: String
//    let episode: [String]
//    let url: String
//    let created: String
    
    private func setUpSections(){
        sections = [
            // Sets the character image
            .photo(viewModel: .init(imageUrl: URL(string: character.image))),
            
            // Sets the character information
            .information(viewModel: [
                .init(type: .status ,value: character.status.text),
                .init(type: .gender,value: character.gender.rawValue),
                .init(type: .type,value: character.type),
                .init(type: .species,value: character.species),
                .init(type: .origin,value: character.origin.name),
                .init(type: .location,value: character.location.name),
                .init(type: .created,value: character.created),
                .init(type: .episodeCount,value: "\(character.episode.count)"),
                ]),
            // Sets the character episodes
            .episodes(viewModel: character.episode.compactMap({
                    return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0))
                }))
            ]
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
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
