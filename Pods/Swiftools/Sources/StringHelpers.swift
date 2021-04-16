//
//  StringHelpers.swift
//  Swiftools
//
//  Created by Yulia Novikova on 5/9/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Trimmed {
    private(set) var value: String = ""

    public var wrappedValue: String {
        get { return value }
        set { value = newValue.trimmingCharacters(in: .whitespacesAndNewlines) }
    }

    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}


public extension String {
    
    var stripHTML: String? {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    var strip: String? {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public extension Optional where Wrapped == String {
    
    var isEmpty: Bool {
        switch self {
        case .none: return true
        case let .some(string): return string.isEmpty
        }
    }
    
    var notEmpty: String? {
        switch self {
        case .none: return nil
        case let .some(string): return string.isEmpty ? nil : string
        }
    }
    
    var anyString: String {
        switch self {
        case .none: return ""
        case let .some(string): return string
        }
    }

}

