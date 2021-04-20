//
//  UIImageTools.swift
//  HelperKit
//
//  Created by Yulia Novikova on 5/15/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    func animateTapWithHighlight() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
    }
    
}
