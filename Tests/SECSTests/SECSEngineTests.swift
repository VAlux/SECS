//
//  EngineTests.swift
//  
//
//  Created by Alexander Voievodin on 24.04.2022.
//

import XCTest
import SECS

final class SECSEngineTests : XCTestCase {

    private let shipSystem =
        TestIteratingSystem(family: .init(matchers: .allOf(components: [HullComponent.self, EngineComponent.self])))

    private let playerSystem =
        TestIteratingSystem(family: .init(matchers: .allOf(components: [PlayerComponent.self])))

    private let ship = Entity(components: EngineComponent(), HullComponent())

    private var engine: Engine!

    override func setUp() {
        self.engine = Engine()
    }

    func testUpdate() {
        engine.register(system: shipSystem)
        engine.register(system: playerSystem)
        engine.register(entity: ship)

        engine.update()

        XCTAssertTrue(shipSystem.processed)
        XCTAssertFalse(playerSystem.processed)
    }

    func testRegistrationOrder() {
        engine.register(entity: ship)
        engine.register(system: shipSystem)
        engine.register(system: playerSystem)

        engine.update()

        XCTAssertTrue(shipSystem.processed)
        XCTAssertFalse(playerSystem.processed)
    }
}

private extension SECSEngineTests {
    class TestIteratingSystem: IteratingSystem {
        var processed = false

        override func process(entity: Entity) {
            self.processed = true
        }
    }

    class HullComponent: Component {}
    class EngineComponent: Component {}
    class PlayerComponent: Component {}
}

