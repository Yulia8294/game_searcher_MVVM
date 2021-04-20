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
    
    func updateHeight() {
        DispatchQueue.main.async {
            self.beginUpdates()
            self.endUpdates()
        }
    }
    
       
    func allIndexPaths() -> [IndexPath] {
        var indexPaths = [IndexPath]()
        
        let sections = self.numberOfSections
        if sections > 0 {
            for section in 0...sections - 1 {
                let rows = self.numberOfRows(inSection: section)
                if rows > 0 {
                    for row in 0...rows - 1 {
                        let index = IndexPath(row: row, section: section)
                        indexPaths.append(index)
                    }
                }
            }
        }
        return indexPaths
    }
       
    func nextIndexPath(for current: IndexPath) -> IndexPath? {
        var nextRow = 0, nextSection = 0, iteration = 0
        var startRow = current.row
        for section in current.section ..< numberOfSections {
            nextSection = section
            for row in startRow ..< numberOfRows(inSection: section) {
                nextRow = row
                iteration += 1
                if iteration == 2 {
                    let nextIndexPath = IndexPath(row: nextRow, section: nextSection)
                    return nextIndexPath
                }
            }
            startRow = 0
        }
        return nil
    }
       
    func previousIndexPath(for current: IndexPath) -> IndexPath? {
        let startRow = current.row, startSection = current.section
        var previousRow = startRow, previousSection = startSection
        
        if startRow == 0 && startSection == 0 {
            return nil
        } else if startRow == 0 {
            previousSection -= 1
            previousRow = numberOfRows(inSection: previousSection) - 1
        } else {
            previousRow -= 1
        }
        return IndexPath(row: previousRow, section: previousSection)
    }
    
    
}
