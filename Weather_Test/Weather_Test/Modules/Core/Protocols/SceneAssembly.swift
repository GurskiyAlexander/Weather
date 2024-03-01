import UIKit

// MARK: - OutputInterface

public protocol OutputInterface {}

// MARK: - InputInterface

public protocol InputInterface {}

// MARK: - AssemblySceneInterface

public protocol SceneAssemblyInterface: AnyObject {
    associatedtype ViewController where ViewController: ViewControllerInterface
    associatedtype ViewModel where ViewModel: ViewModelInterface
    associatedtype Config where Config: ConfigModelInterface

    var controller: ViewController? { get set }
    var viewModel: ViewModel? { get set }
    var config: Config? { get set }
}

// MARK: -

public extension SceneAssemblyInterface {
    func assemble(
        viewController: ViewController,
        viewModel: ViewModel,
        config: Config
    ) {
        let viewController = viewController
        guard
            let controllerViewModel = viewModel as? ViewController.ViewModel
        else {
            fatalError("Failed item doesn`t conforms to protocol \(Self.ViewController.ViewModel.self)")
        }
        viewController.viewModel = controllerViewModel

        guard
            let viewModelController = viewController as? ViewModel.ViewController
        else {
            fatalError("Failed item doesn`t conforms to protocol \(Self.ViewModel.ViewController.self)")
        }
        viewModel.controller = viewModelController

        guard let configInput = viewModel as? Config.Input else {
            fatalError("Failed item doesn`t conforms to protocol \(Config.Input.self)")
        }
        config.input = configInput

        self.config = config
        controller = viewController
        self.viewModel = viewModel
    }
}
