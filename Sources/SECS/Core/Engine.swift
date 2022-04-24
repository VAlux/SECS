//
//  Engine.swift
//  
//
//  Created by Alexander Voievodin on 23.04.2022.
//

import Dispatch
import Combine

public class Engine {

    private var entities: [Entity] = []
    private var systems: [AnySystem] = []
    private let processingQueue = DispatchQueue(label: "Entity processing queue")

    public init() { }

    public func register(entity: Entity) {
        processingQueue.sync {
            entities.append(entity)
            systems.compactMap { $0 as? EntityProcessingSystem }.forEach { $0.offer(entity) }
        }
    }

    public func register(system: AnySystem) {
        processingQueue.sync {
            systems.append(system)

            if let system = system as? EntityProcessingSystem {
                entities.forEach(system.offer(_:))
            }
        }
    }

    public func update() {
        processingQueue.sync {
            systems.forEach { $0.update() }
        }
    }
}
