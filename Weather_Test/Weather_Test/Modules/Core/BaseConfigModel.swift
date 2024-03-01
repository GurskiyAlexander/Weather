import Foundation

// MARK: - BaseConfigModel

open class BaseConfigModel<Input, Output>: ConfigModelInterface {
    private weak var storageInput: AnyObject?
    public var input: Input! {
        get {
            storageInput as? Input
        }
        set {
            storageInput = newValue as? AnyObject
        }
    }

    private weak var storageOutput: AnyObject?
    public var output: Output? {
        get {
            storageOutput as? Output
        }
        set {
            storageOutput = newValue as? AnyObject
        }
    }

    public init(
        output: Output?
    ) {
        self.output = output
    }
}
