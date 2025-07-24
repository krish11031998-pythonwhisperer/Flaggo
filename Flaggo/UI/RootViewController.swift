//
//  RootViewController.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import UIKit
import KKit

class RootViewController: BaseViewController {
  
    var tabType: MainTabViewController.Tabs?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
    }
    
    private func setupNavbar() {
        guard let tabType else { return }
        navigationItem.title = tabType.tabName
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
