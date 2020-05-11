//
//  SceneDelegate.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 03/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import UIKit
import FinniversKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let container = Swinject.Container()
    
    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        registerServices(container: container)

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        defer { self.window = window }

        window.windowScene = windowScene

        let navigationController = NavigationController(rootViewController: container.resolve(HomeViewController.self)!)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        //let userInterfaceStyle = UserInterfaceStyle(rawValue: UserDefaults.standard.integer(forKey: State.currentUserInterfaceStyleKey))
        let userInterfaceStyle = UserInterfaceStyle(rawValue: 2)
        
        FinniversKit.userInterfaceStyleSupport = userInterfaceStyle == .dark ? .forceDark : .forceLight
        
        if #available(iOS 13.0, *) {
            window.setWindowUserInterfaceStyle(userInterfaceStyle)
        }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func registerServices(container: Swinject.Container) {
        container.register(HomeViewController.self, factory: { _ in HomeViewController(user: User(name: "Andreas")) })
        // container.autoregister(HomeViewController.self, initializer: HomeViewController.init)
    }
}
