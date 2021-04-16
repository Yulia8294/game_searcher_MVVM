//
//  UIColorTools.swift
//  Swiftools
//
//  Created by Yulia Novikova on 5/9/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

public extension UIColor {
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    
}
