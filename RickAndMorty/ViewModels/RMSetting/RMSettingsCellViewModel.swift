//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-02-07.
//

import Foundation
import UIKit

// The cells will have an image and title
// Identifiable gives us a unique id that is genereted when we loop over the cells
struct RMSettingsCellViewModel: Identifiable, Hashable {
    
    // creates a unique id for each of the cell view models instances created
    let id = UUID()
    
    // create a reference to the RMSettingsOption enums
    private let type: RMSettingsOption
    
    // MARK: - Initializer
    // the cell view model will be initialized with the following
    init(type: RMSettingsOption) {
        self.type = type
    }
    
    // MARK: - Pulic funcs
    // slang: Expose this
    // Return the icon image computed property in RMSettingsOption
    public var image: UIImage? {
        return type.iconImage
    }
    // Return the display title computed property in RMSettingsOption
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
}
