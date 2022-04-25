//
//  SECSEntityTests.swift
//  
//
//  Created by Alexander Voievodin on 25.04.2022.
//

import XCTest
import SECS

final class SECSEntityTests : XCTestCase {

    func testComponentRetrieval() {
        let hull = HullComponent()
        let engine = EngineComponent()
        let shipEntity = Entity(components: hull, engine)

        let retrievedHullComponent = shipEntity.component(for: HullComponent.self)
        let retrievedPlayerComponent = shipEntity.component(for: PlayerComponent.self)

        XCTAssertNotNil(retrievedHullComponent, "Retrieved hull component is nil!")
        XCTAssertNil(retrievedPlayerComponent, "Retrieved player component is not nil!")
    }

    func testRemoveComponent() {
        let hull = HullComponent()
        let engine = EngineComponent()
        let shipEntity = Entity(components: hull, engine)

        shipEntity.remove(engine)

        let retrievedHullComponent = shipEntity.component(for: HullComponent.self)
        let retrievedEngineComponent = shipEntity.component(for: EngineComponent.self)

        XCTAssertNil(retrievedEngineComponent, "Retrieved engine component is not nil!")
        XCTAssertNotNil(retrievedHullComponent, "Retrieved hull component is nil!")

        shipEntity.remove(for: HullComponent.self)
        let hullComponent = shipEntity.component(for: HullComponent.self)

        XCTAssertNil(hullComponent, "Hull component is not removed!")
    }
}

private extension SECSEntityTests {
    class HullComponent: Component {}
    class EngineComponent: Component {}
    class PlayerComponent: Component {}
}
