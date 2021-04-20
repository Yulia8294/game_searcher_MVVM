//
//  LoadingButton.swift
//  HelperKit
//
//  Created by Yulia Novikova on 8/26/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

@IBDesignable
open class LoadingButton: UIButton {

    @IBInspectable var indicatorColor : UIColor = .white

    var originalTitleText: String?
    var activityIndicator: UIActivityIndicatorView!

    func show() {
        originalTitleText = self.titleLabel?.text
        self.setTitle("", for: .normal)

        if (activityIndicator == nil) {
            activityIndicator = generateIndicator()
        }

        showSpinning()
    }

    func hide() {
        DispatchQueue.main.async(execute: {
            self.setTitle(self.originalTitleText, for: .normal)
            self.activityIndicator.stopAnimating()
        })
    }

    private func generateIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = indicatorColor
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }

    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }

    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }

}
