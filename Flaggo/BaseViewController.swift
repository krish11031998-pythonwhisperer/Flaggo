//
//  BaseViewController.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 2025-07-24.
//

import UIKit
import KKit

class BaseViewController: UIViewController {
    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
        activityIndicator
            .pinCenterXAnchorTo(constant: 0)
            .pinCenterYAnchorTo(constant: 0)
    }
    
}
