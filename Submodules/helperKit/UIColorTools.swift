//
//  UIColorTools.swift
//  HelperKit
//
//  Created by Yulia Novikova on 8/26/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience init(_ red:Int, _ green:Int, _ blue:Int, _ alpha:CGFloat) {
        self.init(red:   CGFloat(red)   / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue:  CGFloat(blue)  / 255.0,
                  alpha: alpha)
    }
    
    convenience init(_ red:Int, _ green:Int, _ blue:Int) {
        self.init(red, green, blue, 1)
    }
    
    static var random:UIColor {
        return UIColor(Int(arc4random_uniform(255)),
                       Int(arc4random_uniform(255)),
                       Int(arc4random_uniform(255)))
    }
}
