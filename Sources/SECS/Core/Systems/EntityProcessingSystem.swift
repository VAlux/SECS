//
//  File.swift
//  
//
//  Created by Alexander Voievodin on 19.04.2022.
//

import CoreGraphics

protocol EntityProcessingSystem: AnySystem {
    func process(entity: Entity, deltaTime: CGFloat)

    func offer(_ entity: Entity)

    func remove(_ entity: Entity)
}
