//
//  InsetLabel.swift
//  HelperKit
//
//  Created by Yulia Novikova on 5/7/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

@IBDesignable open class InsetLabel: UILabel {
    
    @IBInspectable
    var topInset: CGFloat = 0
    
    @IBInspectable open var bottomInset: CGFloat = 0
    
    @IBInspectable open var leftInset: CGFloat = 0
    
    @IBInspectable open var rightInset: CGFloat = 0
    
    open override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override public var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}
