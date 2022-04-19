import XCTest
@testable import SECS

final class SECSFamilyTests: XCTestCase {
    private let hullComponent = HullComponent()
    private let engineComponent = EngineComponent()
    private let playerComponent = PlayerComponent()
    
    func testCompliesAll() throws {
        let family = Family()
        family.all(components: hullComponent, engineComponent, playerComponent)
        
        let shipEntityComplete = createCompleteShipEntity()
        let resultFullyComplies = family.complies(to: shipEntityComplete)
        
        XCTAssertTrue(resultFullyComplies)
        
        let shipEntityIncomplete = Entity()
        shipEntityIncomplete.add(hullComponent)
        shipEntityIncomplete.add(playerComponent)
        
        let resultNotComply = family.complies(to: shipEntityIncomplete)
        
        XCTAssertFalse(resultNotComply)
    }
    
    func testCompliesOne() throws {
        let family = Family()
        family.one(component: hullComponent)
        
        let shipEntityComplete = createCompleteShipEntity()
        let resultComplies = family.complies(to: shipEntityComplete)
        
        XCTAssertTrue(resultComplies)
        
        let shipEntityWithoutHull = Entity()
        shipEntityWithoutHull.add(engineComponent)
        shipEntityWithoutHull.add(playerComponent)
        
        let resultNotComply = family.complies(to: shipEntityWithoutHull)
        
        XCTAssertFalse(resultNotComply)
    }
    
    func testCompliesExclude() throws {
        let family = Family()
        family.exclude(component: engineComponent)
        
        let shipEntityWithoutEngine = Entity()
        shipEntityWithoutEngine.add(hullComponent)
        shipEntityWithoutEngine.add(playerComponent)
        
        let resultComplies = family.complies(to: shipEntityWithoutEngine)
        
        XCTAssertTrue(resultComplies)
        
        let shipEntityComplete = createCompleteShipEntity()
        let resultNotComply = family.complies(to: shipEntityComplete)
        
        XCTAssertFalse(resultNotComply)
    }
    
    func testFamiliesEqual() throws {
        let familyOne = Family()
        familyOne.all(components: hullComponent, engineComponent)
        
        let familyTwo = Family()
        familyTwo.all(components: hullComponent, engineComponent)
        
        let familyThree = Family()
        familyTwo.all(components: engineComponent)
        
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
