//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-08.
//

import Foundation
import UIKit

final class RMCharacterInfoCollectionViewCellViewModel
{
    private let type: `Type`
    private  let value: String
    
    // Original date formatter
    static let dateFormatter: DateFormatter = {
        // Format date
        // Date in api to be formatted 2017-11-04T18:50:21.651Z
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    // Formated  short date
    static let shortDateFormatter: DateFormatter = {
        // Format date
        // Date in api to be formatted 2017-11-04T18:50:21.651Z
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    
    public var title: String {
        self.type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty {return "None"}
        
        if let date = Self.dateFormatter.date(from: value),
           type == .created {
            return Self.shortDateFormatter.string(from: date)
        }
        return value
    }
    
public var iconImage: UIImage? {
    return type.iconImage
}

public var tintColor: UIColor {
    return type.tintColor
}
enum `Type`: String {
    case status
    case gender
    case type
    case species
    case origin
    case location
    case created
    case episodeCount
    
    var tintColor: UIColor {
        switch self {
        case .status:
            return .systemCyan
        case .gender:
            return .systemRed
        case .type:
            return .systemGray
        case .species:
            return .systemBlue
        case .origin:
            return .systemPink
        case .location:
            return .systemTeal
        case .created:
            return .systemMint
        case .episodeCount:
            return .systemYellow
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .status:
            return UIImage(systemName: "bell")
        case .gender:
            return UIImage(systemName: "bell")
        case .type:
            return UIImage(systemName: "bell")
        case .species:
            return UIImage(systemName: "bell")
        case .origin:
            return UIImage(systemName: "bell")
        case .location:
            return UIImage(systemName: "bell")
        case .created:
            return UIImage(systemName: "bell")
        case .episodeCount:
            return UIImage(systemName: "bell")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .status,
                .gender,
                .type,
                .species,
                .origin,
                .location,
                .created:
            return rawValue.uppercased()
        case .episodeCount:
            return "EPISODE COUNT"
        }
    }
}

init(type: `Type`, value: String)
{
    self.value = value
    self.type = type
}
}
