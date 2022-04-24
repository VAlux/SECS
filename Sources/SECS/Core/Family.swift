public final class Family: Hashable {
    private var all = Set<String>()
    private var either = Set<String>()
    private var exclude = Set<String>()

    public enum ComponentMatcher {
        case allOf(components: [Component.Type])
        case eitherOf(components: [Component.Type])
        case noneOf(components: [Component.Type])
    }

    public init(matchers: ComponentMatcher...) {
        for matcher in matchers {
            switch(matcher) {
            case .allOf(let components):
                all.formUnion(components.map { $0.identifier })
            case .eitherOf(let components):
                either.formUnion(components.map { $0.identifier })
            case .noneOf(let components):
                exclude.formUnion(components.map { $0.identifier })
            }
        }
    }
    
    public func complies(to entity: Entity) -> Bool {
        let entityComponents = entity.componentTypeIds
        
        if !all.isSubset(of: entityComponents) {
            return false
        }
        
        if !either.isEmpty && entityComponents.intersection(either).isEmpty {
            return false
        }
        
        if !exclude.isEmpty && !entityComponents.intersection(exclude).isEmpty {
            return false
        }
        
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(all.hashValue)
        hasher.combine(either.hashValue)
        hasher.combine(exclude.hashValue)
    }
    
    public static func == (lhs: Family, rhs: Family) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
