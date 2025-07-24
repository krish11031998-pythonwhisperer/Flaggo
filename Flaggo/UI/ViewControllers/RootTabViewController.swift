//
//  RootTabViewController.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 2025-07-23.
//

import Foundation
import UIKit

class RootTabViewController: UINavigationController {
    
    private let tabType: MainTabViewController.Tabs
    
    init(tab: MainTabViewController.Tabs, rootViewController: RootViewController) {
        self.tabType = tab
        super.init(rootViewController: rootViewController)
        rootViewController.tabType = tab
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItem()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemBackground
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupTabBarItem() {
        self.tabBarItem = tabType.tabItem
    }
}
