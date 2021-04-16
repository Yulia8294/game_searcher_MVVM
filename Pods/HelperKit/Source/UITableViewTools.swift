//
//  UITableViewTools.swift
//  HelperKit
//
//  Created by Yulia Novikova on 5/7/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

public extension UITableView {
    
    func cell<T>(_ type: T.Type) -> T {
        dequeueReusableCell(withIdentifier: String(describing: type)) as! T
    }
    
    func registerCell<T>(_ type: T.Type) {
        let nib = UINib(nibName: String(describing: type), bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: type))
    }
    
    func registerHeader<T>(_ type: T.Type) {
        let nib = UINib(nibName: String(describing: type), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: type))
    }
    
    func header<T>(_ type: T.Type) -> T {
        dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as! T
    }
}
