//
//  IteratingSystem.swift
//
//  Created by Alexander Voievodin on 19.04.2022.
//

import CoreGraphics

open class IteratingSystem : EntityProcessingSystem {
    var family: Family
    var entities: [Entity] = []
    
    public init(family: Family) {
        self.family = family
    }

    func offer(_ entity: Entity) {
        if family.complies(to: entity) {
            self.entities.append(entity)
        }
    }

    func remove(_ entity: Entity) {
        if let index = entities.firstIndex(where: { $0 == entity }) {
            entities.remove(at: index)
        }
    }

    public func update(deltaTime: CGFloat) {
        entities.forEach { entity in process(entity: entity, deltaTime: deltaTime) }
    }
    
    open func process(entity: Entity, deltaTime: CGFloat) { }
}
