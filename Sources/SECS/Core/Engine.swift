//
//  Engine.swift
//  
//
//  Created by Alexander Voievodin on 23.04.2022.
//

import Dispatch
import Combine

public class Engine {

    private(set) var entities: [Entity] = []
    private(set) var systems: [String: AnySystem] = [:]
    private let processingQueue = DispatchQueue(label: "Engine processing queue")

    public init() { }

    public func register(entity: Entity) {
        processingQueue.sync {
            entities.append(entity)
            systems.values.compactMap { $0 as? EntityProcessingSystem }.forEach { $0.offer(entity) }
        }
    }

    public func remove(entity: Entity) {
        processingQueue.sync {
            guard let candidate = entities.removeFirst(entity) else { return }
            systems.values.compactMap{ $0 as? EntityProcessingSystem }.forEach { $0.remove(candidate) }
        }
    }

    public func register(system: AnySystem) {
        processingQueue.sync {
            systems[system.identifier] = system

            if let system = system as? EntityProcessingSystem {
                entities.forEach(system.offer(_:))
            }
        }
    }

    public func remove(system: AnySystem) {
        processingQueue.sync {
            systems[system.identifier] = nil
        }
    }

    public func update() {
        processingQueue.sync {
            systems.values.forEach { $0.update() }
        }
    }
}
