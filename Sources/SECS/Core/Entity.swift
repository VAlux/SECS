public class Entity {
    
    fileprivate(set) var components: [String: Component] = [:]
    fileprivate(set) var componentTypeIds: Set<String> = []

    public init(components: Component...) {
        for component in components {
            add(component, with: component.identifier)
        }
    }
    
    public func component<T: Component>(for type: T.Type) -> T? {
        components[type.identifier] as? T
    }

    @discardableResult
    func add<T: Component>(_ component: T) -> T {
        let identifier = T.identifier
        components[identifier] = component
        componentTypeIds.insert(identifier)
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

extension Entity: Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
        componentTypeIds.forEach { hasher.combine($0.hashValue) }
    }

    public static func == (lhs: Entity, rhs: Entity) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
