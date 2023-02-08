//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-27.
//

import UIKit
import SwiftUI

/// Controller to show and search for settings
final class RMSettingsViewController: UIViewController
{
    // compact map to loop over all the cases
//    private let viewModel = RMSettingsViewViewModel(cellViewModel: RMSettingsOption.allCases.compactMap({
//        // everytime we loop the RMSettings option we are going to return RMSettingsCellViewModel, therefore getting all the cell view models  wanted
//        return RMSettingsCellViewModel(type: $0)
//    }))
    
    // Link up swiftui to uikit
    // call the view model here
    private let settingsView = _UIHostingView(
        rootView: RMSettingsView(viewModel: RMSettingsViewViewModel(cellViewModel: RMSettingsOption.allCases.compactMap({
            // everytime we loop the RMSettings option we are going to return RMSettingsCellViewModel, therefore getting all the cell view models  wanted
            return RMSettingsCellViewModel(type: $0)
        }))))
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Settings"
    }

}
