import UIKit

// MARK: - OutputInterface

public protocol BaseOutputInterface: OutputInterface {}

// MARK: - InputInterface

public protocol BaseInputInterface: InputInterface {}

// MARK: - BaseAssembly

public protocol BaseAssemblyProtocol: AnyObject {
    func coordinator() -> BaseCoordinator
}

// MARK: - BaseAssemblyImpl

open class BaseAssembly: BaseAssemblyProtocol {
    public required init() {}

    //  swiftlint:disable unavailable_function
    open func coordinator() -> BaseCoordinator {
        fatalError("this method must be overridden")
    }

    //  swiftlint:enable unavailable_function
}
