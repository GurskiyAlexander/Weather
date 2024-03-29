import Foundation

// MARK: - ConfigModelInterface

public protocol ConfigModelInterface: AnyObject {
    associatedtype Input
    associatedtype Output

    var input: Input! { get set }
    var output: Output? { get set }
}
