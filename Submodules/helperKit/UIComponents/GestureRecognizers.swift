//
//  GestureRecognizers.swift
//  HelperKit
//
//  Created by Yulia Novikova on 5/12/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

fileprivate struct LazyRecognizer {
    
    weak var view: UIView?
    var action: () -> ()
}

fileprivate class LazyRecognizersManager {
    
    static var recognizers = [LazyRecognizer]()
    
    @objc static func handleTap(_ sender: UITapGestureRecognizer) {
        
        (recognizers.filter { $0.view == sender.view }).first?.action()
    }
}

public extension UIView {
    
    func onTap(_ action: @escaping () -> ()) {
        
        let recognizer = UITapGestureRecognizer(target: LazyRecognizersManager.self, action: #selector(LazyRecognizersManager.handleTap(_:)))
        
        addGestureRecognizer(recognizer)
        LazyRecognizersManager.recognizers.append(LazyRecognizer(view: self, action: action))
    }
}
