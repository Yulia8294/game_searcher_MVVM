//
//  StoryboardInstantiable.swift
//  ExampleMVVM
//
//  Created by Yulia Novikova on 4/15/21.
//  Copyright © 2021 Yulia. All rights reserved.

import UIKit

public protocol Storyboarded: NSObjectProtocol {
    associatedtype T
    
    static var defaultFileName: String { get }
    
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

public extension Storyboarded where Self: UIViewController {
    
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return vc
    }
}
