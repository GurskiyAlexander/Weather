import UIKit

public protocol ConfigurableView {

    associatedtype Model
    func configure(with model: Model)
}
