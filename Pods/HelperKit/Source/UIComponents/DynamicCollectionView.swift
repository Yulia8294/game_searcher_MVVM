//
//  DynamicCollectionView.swift
//  HelperKit
//
//  Created by Yulia Novikova on 5/8/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

open class DynamicCollectionView: UICollectionView {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.invalidateIntrinsicContentSize()
    }
    
    open override var intrinsicContentSize: CGSize {
        let contentSize = self.collectionViewLayout.collectionViewContentSize
        return contentSize
    }
}
