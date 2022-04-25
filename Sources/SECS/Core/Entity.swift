import AppKit
import XCTest

public class Entity {
    fileprivate(set) var components: [String: Component] = [:]
    fileprivate(set) var componentTypeIds: Set<String> = []

    public init(components: Component...) {
        for component in components {
            add(component, with: type(of: component).identifier)
        }
    }
    
    public func component<T: Component>(for type: T.Type) -> T? {
        components[type.identifier] as? T
    }

    @discardableResult
    public func add<T: Component>(_ component: T) -> T {
        add(component, with: T.identifier)
        return component
    }
    
    @discardableResult
    public func remove<T: Component>(_ component: T) -> T? {
        components.removeValue(forKey: T.identifier) as? T
    }

    @discardableResult
    public func remove<T: Component>(for type: T.Type) -> T? {
        components.removeValue(forKey: T.identifier) as? T
    }

    private func add(_ component: Component, with identifier: String) {
        components[identifier] = component
        componentTypeIds.insert(identifier)
    }
}

extension Entity: CustomStringConvertible {
    public var description: String {
        components.description
    }
}
