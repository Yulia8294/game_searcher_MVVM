//
//  Log.swift
//  Framework tests
//
//  Created by Yulia Novikova on 2/17/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import Foundation

public enum LogType {
    
    case info
    case info2
    case warning
    case error
    
}

public let emptyMessage = "emptyMessage"

public class LogSymbol {
    
    public static var info = "💚"
    public static var info2 = "🦄"
    public static var warning = "💛"
    public static var error = "❤️"
    
    public static var enabled = true
}

fileprivate class Logger {
    
    fileprivate static func log(_ message: Any?, _ type: LogType, _ file: String, _ function: String, _ line: Int) {
        
        if !LogSymbol.enabled { return }
        
        var logString: String
        let file = file.replacingOccurrences(of: ".swift", with: "")
        
        switch type {
        case .info:    logString = "\(LogSymbol.info) INFO \(LogSymbol.info)"
        case .info2:   logString = "\(LogSymbol.info2) INFO \(LogSymbol.info2)"
        case .warning: logString = "\(LogSymbol.warning) WARNING \(LogSymbol.warning)"
        case .error:   logString = "\(LogSymbol.error) ERROR \(LogSymbol.error)"
        }
        
        var logMessage = "[\(logString)]"
        
        logMessage.append("[\(file)::\(function) - \(line)]")
        
        if message as? String != emptyMessage {
            if let message = message { logMessage.append(" " + String(describing: message)) }
            else                     { logMessage.append(" nil") }
        }
        
        print(logMessage)
    }
}

public func Log(_ message: Any? = emptyMessage, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    Logger.log(message, .info, file, function, line)
}

public func LogInfo(_ message: Any? = emptyMessage, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    Logger.log(message, .info2, file, function, line)
}

public func LogWarning(_ message: Any? = emptyMessage, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    Logger.log(message, .warning, file, function, line)
}

public func LogError(_ message: Any? = emptyMessage, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    Logger.log(message, .error, file, function, line)
}
