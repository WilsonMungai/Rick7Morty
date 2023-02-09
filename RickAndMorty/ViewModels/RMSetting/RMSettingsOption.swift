//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-02-07.
//

// Lists all cases in settings
import Foundation
import UIKit

// CaseIterable enables us to loop over all the cases stated
enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "http://iosacademy.io")
        case .terms:
            return URL(string: "http://iosacademy.io/terms")
        case .privacy:
            return URL(string: "http://iosacademy.io/privacy")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/documentation")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/playlist?list=PL5PR3UyfTWvdl4Ya_2veOB6TM16FXuv4y")
        case .viewCode:
            return URL(string: "https://github.com/AfrazCodes/RickAndMortyiOSApp")
        }
    }
    
    // computed property for title
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy"
        case .apiReference:
            return "API Reference"
        case .viewSeries:
            return "View Video Series"
        case .viewCode:
            return "View App Code"
        }
    }
    
    // computed property for color
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUs:
            return .systemCyan
        case .terms:
            return .systemPurple
        case .privacy:
            return .systemOrange
        case .apiReference:
            return .systemYellow
        case .viewSeries:
            return .systemRed
        case .viewCode:
            return .systemPink
        }
    }
    // computed property for image
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane.fill")
        case .terms:
            return UIImage(systemName: "doc.fill")
        case .privacy:
            return UIImage(systemName: "lock.fill")
        case .apiReference:
            return UIImage(systemName: "list.clipboard.fill")
        case .viewSeries:
            return UIImage(systemName: "play.tv.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}
