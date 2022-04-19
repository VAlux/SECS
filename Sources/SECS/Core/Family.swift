class Family: Hashable {
    private var all = Set<String>()
    private var one = Set<String>()
    private var exclude = Set<String>()
    
    func all(components: Component...) {
        components.map { type(of: $0).identifier }.forEach { all.insert($0) }
    }
    
    func one(component: Component) {
        one.insert(type(of: component).identifier)
    }
    
    func exclude(component: Component) {
        exclude.insert(type(of: component).identifier)
    }
    
    func complies(to entity: Entity) -> Bool {
        let entityComponents = entity.componentTypeIds
        
        if !all.isSubset(of: entityComponents) {
            return false
        }
        
        if !one.isEmpty && entityComponents.intersection(one).isEmpty {
            return false
        }
        
        if !exclude.isEmpty && !entityComponents.intersection(exclude).isEmpty {
            return false
        }
        
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(all.hashValue)
        hasher.combine(one.hashValue)
        hasher.combine(exclude.hashValue)
    }
    
    static func == (lhs: Family, rhs: Family) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
