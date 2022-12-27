//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-27.
//

import UIKit

final class RMTabBarController: UITabBarController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpTabs()
    }

    // Function to attach tab view controllers to the tab view
    private func setUpTabs()
    {
        let characterVC = RMCharacterViewController()
        let locationVC = RMLocationViewController()
        let episodesVC = RMEpisodeViewController()
        let settingsVC = RMSettingsViewController()
        
        // Sets large titles
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        // Embeddes the views into a navigation view controller
        let nav1 = UINavigationController(rootViewController: characterVC)
        let nav2 = UINavigationController(rootViewController: locationVC)
        let nav3 = UINavigationController(rootViewController: episodesVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)
        
        // Displays the tab bar titles at the bottom with icons
        nav1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        // Displays large titles
        for nav in [nav1, nav2, nav3, nav4]
        {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        // Attaches the view controllers to the tabs
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
}

