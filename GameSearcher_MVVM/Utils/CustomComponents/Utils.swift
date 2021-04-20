//
//  Utils.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/27/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

//done
extension String {
    
    func strip() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}


extension UIImageView {
    
    func loadImage(_ urlString: String?) {
        guard let string = urlString else { return }
        guard let url = URL(string: string) else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}

func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
     var gradientImage:UIImage?
     UIGraphicsBeginImageContext(gradientLayer.frame.size)
     if let context = UIGraphicsGetCurrentContext() {
         gradientLayer.render(in: context)
         gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
     }
     UIGraphicsEndImageContext()
     return gradientImage
}



public extension Array where Element : Hashable {
    var unique: [Element] { return Array(Set(self)) }
    
}

public extension Array {
    var randomElement: Element? {
        if count == 0 { return nil }
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
}

extension String {
    var trim: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}



