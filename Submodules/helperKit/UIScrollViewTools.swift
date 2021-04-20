//
//  UIScrollViewTools.swift
//  HelperKit
//
//  Created by Yulia Novikova on 5/7/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

public extension UIScrollView {
    
    func scrollToBottom(animated: Bool = false) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    var aboutToReachTop: Bool {
        let upperEdge = bounds.size.height * 0.10 - contentInset.top
        return contentOffset.y <= upperEdge
    }
    
    var reachedTop: Bool {
        let topEdge = 0 - contentInset.top
        return contentOffset.y <= topEdge
    }
    
    var reachedBottom: Bool {
        let bottomEdge = contentSize.height + contentInset.bottom - bounds.size.height
        return contentOffset.y >= bottomEdge
    }
    
}
