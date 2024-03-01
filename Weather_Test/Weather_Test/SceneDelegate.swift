//
//  SceneDelegate.swift
//  Weather
//
//  Created by Alex Gurskiy on 29.02.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var assembly: BaseAssemblyProtocol?
    private var coordinator: Coordinator!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupApp()
    }

    func setupApp() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        guard let window = window else { return }
        let useCasesAssembly = UseCasesAssemblyImpl()
        useCasesAssembly.mainUseCase.getLocation()
        let assembly = setupMainAssembly(window: window, useCasesAssembly: useCasesAssembly)
        self.assembly = assembly
        coordinator = assembly.coordinator()
        window.rootViewController = coordinator.rootViewController
        self.window = window
        window.makeKeyAndVisible()
        coordinator.start()
    }

    private func setupMainAssembly(window: UIWindow, useCasesAssembly: UseCasesAssemblyImpl) -> BaseAssemblyProtocol {
        MainAssembly(window: window, useCasesAssembly: useCasesAssembly)
    }
}
