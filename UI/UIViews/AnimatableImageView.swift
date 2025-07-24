//
//  AnimatableImageView.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import UIKit
import Kingfisher

public class AnimatableImageView: UIImageView {
    
    private lazy var animator: UIViewPropertyAnimator = .init()
    private lazy var maskLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.black.cgColor
        return layer
    }()
    
    public var contentOffset: CGFloat = 0 {
        didSet {
            let pct = min(1 , max(0, contentOffset/(bounds.height)))
            animator.fractionComplete = 1 - pct
            maskLayer.path = UIBezierPath(rect: .init(origin: .zero, size: .init(width: bounds.width, height: bounds.height * pct))).cgPath
        }
    }
    
    public init() {
        super.init(frame: .zero)
        self.contentMode = .scaleAspectFit
        setupAnimator()
        layer.mask = maskLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        maskLayer.path = UIBezierPath(rect: bounds).cgPath
    }

    
    // MARK: - Protected Methods
    
    private func setupAnimator() {
        animator.addAnimations {
            self.alpha = 0
        }
        animator.pausesOnCompletion = true
        animator.isInterruptible = true
    }
    
    
    // MARK: - Public Methods
    
    public func setImage(imageURLPath: String) {
        KF.url(.init(string: imageURLPath))
            .fade(duration: 0.25)
            .placeholder(UIImage(systemName: "photo.fill"))
            .set(to: self)
    }
   
    
    deinit {
        animator.stopAnimation(true)
    }
    
}
