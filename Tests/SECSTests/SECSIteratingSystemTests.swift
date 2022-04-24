//
//  SECSIteratingSystemTests.swift
//  
//
//  Created by Alexander Voievodin on 23.04.2022.
//

import XCTest
@testable import SECS

final class SECSIteratingSystemTests: XCTestCase {
    private let hullComponent = HullComponent()
    private let engineComponent = EngineComponent()
    private let playerComponent = PlayerComponent()

    override func setUp() {
        super.setUp()
    }
    
    func testEntityProcessed() {
        let allMatcherSystem =
            TestIteratingSystem(family: .init(matchers: .allOf(components: [HullComponent.self, EngineComponent.self])))

        let eitherMatcherSystem =
            TestIteratingSystem(family: .init(matchers: .eitherOf(components: [PlayerComponent.self])))

        let noneMatcherSystem =
            TestIteratingSystem(family: .init(matchers: .noneOf(components: [HullComponent.self])))

        let ship = Entity()
        ship.add(hullComponent)
        ship.add(engineComponent)

        allMatcherSystem.offer(ship)
        eitherMatcherSystem.offer(ship)
        noneMatcherSystem.offer(ship)

        allMatcherSystem.update()
        eitherMatcherSystem.update()
        noneMatcherSystem.update()

        XCTAssertTrue(allMatcherSystem.processed)
        XCTAssertFalse(eitherMatcherSystem.processed)
        XCTAssertFalse(noneMatcherSystem.processed)
    }
}

class TestIteratingSystem: IteratingSystem {
    var processed = false

    override func process(entity: Entity) {
        self.processed = true
    }
}

private class HullComponent: Component {}
private class EngineComponent: Component {}
private class PlayerComponent: Component {}
