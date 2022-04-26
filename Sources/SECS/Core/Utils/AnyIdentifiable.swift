//
//  File.swift
//  
//
//  Created by Alexander Voievodin on 25.04.2022.
//

public protocol AnyIdentifiable {}

extension AnyIdentifiable {
    static var identifier: String {
        String(describing: self)
    }

    var identifier: String {
        type(of: self).identifier
    }
}
