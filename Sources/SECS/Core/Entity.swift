class Entity {
    fileprivate(set) var components: [String: Component] = [:]
    fileprivate(set) var componentTypeIds: Set<String> = []
    
    func component<T: Component>(for type: T.Type) -> T? {
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
    func remove<T: Component>(_ component: T) -> T? {
        components.removeValue(forKey: T.identifier) as? T
    }
}
