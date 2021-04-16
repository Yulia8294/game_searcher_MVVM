//
//  UIViewControllerTools.swift
//  HelperKit
//
//  Created by Yulia Novikova on 5/7/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func push(_ controller: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func present(_ controller: UIViewController, animated: Bool = true) {
        present(controller, animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool = true) {
        dismiss(animated: animated, completion: nil)
    }
    
    func presentFullScreen(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
    func popToRootController(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
}
