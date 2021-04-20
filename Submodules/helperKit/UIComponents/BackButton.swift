//
//  BackButton.swift
//  HelperKit
//
//  Created by Yulia Novikova on 6/18/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

open class BackButton : UIButton {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addTarget(self, action: #selector(self.didTap), for: .touchUpInside)
    }
    
    @objc private func didTap() {
        guard let controller = viewController else { print("Back button error"); return }
        if let nav = controller.navigationController {
            nav.popViewController(animated: true)
        }
        else {
            controller.dismiss()
        }
    }
}
