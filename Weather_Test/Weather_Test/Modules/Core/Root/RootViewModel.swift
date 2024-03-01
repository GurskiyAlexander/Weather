import Foundation

// MARK: - RootViewModelProtocol

public protocol RootViewModelProtocol {
    func viewLoaded()
    func viewAppeared()
    func viewDisappear()
}

open class RootViewModel<ViewController, ConfigModel> {
    public var controller: ViewController!

    public let config: ConfigModel

    public required init(config: ConfigModel) {
        self.config = config
    }

    @objc
    open dynamic func viewLoaded() {}

    @objc
    open dynamic func viewAppeared() {}

    @objc
    open func viewDisappear() {}
}

extension RootViewModel: RootViewModelProtocol {}

extension RootViewModel: ViewModelInterface {}
