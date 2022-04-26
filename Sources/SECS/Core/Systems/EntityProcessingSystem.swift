//
//  File.swift
//  
//
//  Created by Alexander Voievodin on 19.04.2022.
//

protocol EntityProcessingSystem: AnySystem {
    func process(entity: Entity)

    func offer(_ entity: Entity)

    func remove(_ entity: Entity)
}
