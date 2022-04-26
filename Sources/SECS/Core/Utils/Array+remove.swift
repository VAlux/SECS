//
//  File.swift
//  
//
//  Created by Alexander Voievodin on 25.04.2022.
//

import Foundation

extension Array where Element: Equatable {
    @discardableResult
    mutating func removeFirst(_ element: Element) -> Element? {
        removeFirst(where: { $0 == element })
    }
}

extension Array {
    @discardableResult
    mutating func removeFirst(where predicate: (Element) -> Bool) -> Element? {
        if let index = firstIndex(where: predicate) {
            return remove(at: index)
        }

        return nil
    }
}
