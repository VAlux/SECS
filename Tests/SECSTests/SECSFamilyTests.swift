import XCTest
import SECS

final class SECSFamilyTests: XCTestCase {
    private let hullComponent = HullComponent()
    private let engineComponent = EngineComponent()
    private let playerComponent = PlayerComponent()
    
    func testCompliesAll() throws {
        let family =
            Family(matchers: .allOf(components: [HullComponent.self, EngineComponent.self, PlayerComponent.self]))

        let shipEntityComplete = createCompleteShipEntity()
        let resultFullyComplies = family.complies(to: shipEntityComplete)
        
        XCTAssertTrue(resultFullyComplies)
        
        let shipEntityIncomplete = Entity(components: hullComponent, playerComponent)
        let resultNotComply = family.complies(to: shipEntityIncomplete)
        
        XCTAssertFalse(resultNotComply)
    }
    
    func testCompliesOne() throws {
        let family = Family(matchers: .eitherOf(components: [HullComponent.self]))
        let shipEntityComplete = createCompleteShipEntity()
        let resultComplies = family.complies(to: shipEntityComplete)
        
        XCTAssertTrue(resultComplies)
        
        let shipEntityWithoutHull = Entity(components: engineComponent, playerComponent)
        let resultNotComply = family.complies(to: shipEntityWithoutHull)
        
        XCTAssertFalse(resultNotComply)
    }
    
    func testCompliesExclude() throws {
        let family = Family(matchers: .noneOf(components: [EngineComponent.self]))

        let shipEntityWithoutEngine = Entity(components: hullComponent, playerComponent)
        let resultComplies = family.complies(to: shipEntityWithoutEngine)
        
        XCTAssertTrue(resultComplies)
        
        let shipEntityComplete = createCompleteShipEntity()
        let resultNotComply = family.complies(to: shipEntityComplete)
        
        XCTAssertFalse(resultNotComply)
    }
    
    func testFamiliesEqual() throws {
        let familyOne = Family(matchers: .allOf(components: [HullComponent.self, EngineComponent.self]))
        let familyTwo = Family(matchers: .allOf(components: [HullComponent.self, EngineComponent.self]))
        let familyThree = Family(matchers: .allOf(components: [EngineComponent.self]))
        let emptyFamily = Family()
        
        XCTAssertTrue(familyOne == familyTwo)
        XCTAssertTrue(familyOne != familyThree)
        XCTAssertTrue(familyOne != emptyFamily)
    }
    
    private func createCompleteShipEntity() -> Entity {
        let shipEntityComplete = Entity()
        shipEntityComplete.add(hullComponent)
        shipEntityComplete.add(engineComponent)
        shipEntityComplete.add(playerComponent)
        
        return shipEntityComplete
    }
}

private class HullComponent: Component {}
private class EngineComponent: Component {}
private class PlayerComponent: Component {}
