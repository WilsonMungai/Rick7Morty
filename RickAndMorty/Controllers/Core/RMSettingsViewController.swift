//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-27.
//

// Show web page
import SafariServices

import StoreKit
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
//    private let settingsSwiftUIController = UIHostingController(
//        rootView: RMSettingsView(viewModel: RMSettingsViewViewModel(cellViewModel: RMSettingsOption.allCases.compactMap({
//            // everytime we loop the RMSettings option we are going to return RMSettingsCellViewModel, therefore getting all the cell view models  wanted
//            return RMSettingsCellViewModel(type: $0)
//        })
//      )
//    ))
    
    // A UIKit view controller that manages a SwiftUI view hierarchy.
    // Takes in a generic which is the view we want to display
    private var settingsSwiftUIController: UIHostingController<RMSettingsView>?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Settings"
        
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        // Link up swiftui to uikit
        // call the view model here
        let settingsSwiftUIController = UIHostingController(
            rootView: RMSettingsView(viewModel: RMSettingsViewViewModel(cellViewModel: RMSettingsOption.allCases.compactMap({
                // everytime we loop the RMSettings option we are going to return RMSettingsCellViewModel, therefore getting all the cell view models  wanted
                return RMSettingsCellViewModel(type: $0) { [weak self] option in
//                    print(option.displayTitle)
                    self?.handleTap(option: option)
                }
               })
             )
           )
        )
        
        // Add it as a child
        addChild(settingsSwiftUIController)
        
        // Notify parent
        settingsSwiftUIController.didMove(toParent: self)
        
        // Add the view
        view.addSubview(settingsSwiftUIController.view)
        
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Pin the view to all the corners
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
        
        self.settingsSwiftUIController = settingsSwiftUIController
    }
    
    private func handleTap(option: RMSettingsOption) {
        // Confirm that this is being called in the main thread
        guard Thread.current.isMainThread else {
            return
        }
        if let url  = option.targetUrl {
            // open website
            // presnt web page
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else if option == .rateApp {
            // show rating prompt
            // displays the rate app window
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}
