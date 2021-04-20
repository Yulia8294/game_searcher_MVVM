//
//  UIScreen.swift
//  HelperKit
//
//  Created by Yulia Novikova on 5/8/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

public struct Screen {
    
    public static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    public static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    public static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 20
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
}
