import Foundation

// MARK: - ViewModelInterface

public protocol ViewModelInterface: AnyObject {
    associatedtype ViewController
    associatedtype ConfigModel

    var controller: ViewController! { get set }
    var config: ConfigModel { get }

    init(config: ConfigModel)
}
