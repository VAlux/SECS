//
//  AnySystem.swift
//  
//
//  Created by Alexander Voievodin on 19.04.2022.
//

import CoreGraphics

public protocol AnySystem: AnyIdentifiable {
    func update(deltaTime: CGFloat)
}
