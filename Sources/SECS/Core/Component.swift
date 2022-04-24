protocol Component {}

extension Component {
    static var identifier: String {
        String(describing: self)
    }
}
