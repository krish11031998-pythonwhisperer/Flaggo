//
//  RootViewController.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import UIKit
import KKit

class RootViewController: UIViewController {
    
    private lazy var acitvityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        return activityIndicator
    }()
    var tabType: MainTabViewController.Tabs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(acitvityIndicator)
        acitvityIndicator
            .pinCenterXAnchorTo(constant: 0)
            .pinCenterYAnchorTo(constant: 0)
        setupNavbar()
    }
    
    private func setupNavbar() {
        navigationItem.title = tabType.tabName
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
