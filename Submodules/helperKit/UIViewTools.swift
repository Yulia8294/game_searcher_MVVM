//
//  UIViewTools.swift
//  HelperKit
//
//  Created by Yulia Novikova on 5/7/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

fileprivate let animationDuration:TimeInterval = 0.25

public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set { clipsToBounds = true; layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    @IBInspectable var borderColor: UIColor {
        set { layer.borderColor = newValue.cgColor }
        get { return UIColor.clear }
    }
    
    var viewController: UIViewController? {
        var controller: UIResponder? = self.next
        while controller != nil {
            if let controller = controller as? UIViewController { return controller }
            controller = controller?.next
        }
        return nil
    }
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func showAnimated() {
        UIView.animate(withDuration: animationDuration) {
            self.isHidden = false
        }
    }
    
    func hideAnimated() {
        UIView.animate(withDuration: animationDuration) {
            self.isHidden = true
        }
    }
    
    func animateDown() {
        animate(transform: CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8))
    }
    
    func animateUp() {
        animate(transform: .identity)
    }
    
    func animate(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 3,
                       options: .allowUserInteraction,
                       animations: {
                        self.transform = transform
        }, completion: nil)
    }
    
    func rotateView(_ angle: CGFloat) {
        UIView.animate(withDuration: animationDuration) {
            self.transform = CGAffineTransform(rotationAngle: angle * .pi / 180)
        }
    }
    
       //MARK: - Dummies
    
    static let dummyTag = "dummy".hash
    
    static var dummy: UIView {
        
        let dummy = UIView(CGRect(x: 0, y: 0, width: 100, height: 100))
        dummy.backgroundColor = UIColor.random
        dummy.tag = dummyTag
        return dummy
    }
    
    func removeDummies() {
        
        for view in self.subviews {
            if view.tag == UIView.dummyTag {
                view.removeFromSuperview()
            }
        }
    }
        
        //MARK: - Initializators
        
        convenience init(_ frame: CGRect) {
            self.init(frame: frame)
        }
        
        convenience init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
            self.init(frame:CGRect(x: x, y: y, width: width, height: height))
        }
        
        convenience init(width:CGFloat, height:CGFloat) {
            self.init(CGRect(x: 0, y: 0, width: width, height: height))
        }
        
        //MARK: - Other
        
        @discardableResult func withColor(_ color:UIColor) -> Self {
            backgroundColor = color
            return self
        }
        
        @discardableResult func withColor(_ r: Int, _ g: Int, _ b: Int) -> Self {
            return self.withColor(UIColor(r, g, b))
        }
        
        @discardableResult func withFrame(_ frame:CGRect) -> Self {
            self.frame = frame
            return self
        }
        
        @discardableResult func withFrame(_ x:CGFloat, _ y:CGFloat, _ width:CGFloat, _ height:CGFloat) -> Self {
            return self.withFrame(CGRect(x: x, y: y, width: width, height: height))
        }
        
        @discardableResult func withSize(_ size: CGSize) -> Self {
            
            var frame = self.frame
            frame.size = size
            self.frame = frame
            return self
        }
        
        @discardableResult func withSize(_ width: CGFloat, _ height: CGFloat) -> Self {
            return self.withSize(CGSize(width: width, height: height))
        }
        
        @discardableResult func circle() -> Self {
            clipsToBounds = true
            layer.cornerRadius = frame.size.height / 2
            return self
        }
    }
