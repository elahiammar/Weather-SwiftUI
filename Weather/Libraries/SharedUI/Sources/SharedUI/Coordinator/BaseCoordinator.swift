public protocol CoordinatorProtocol: AnyObject {
    func start()
}

open class BaseCoordinator: CoordinatorProtocol {
    public init() {}

    open func start() {
        fatalError("Needs to be implemented in the subclass")
    }
}
