//
//  SceneDelegate.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 03/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit
import Swinject
import SwinjectAutoregistration

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let container = Swinject.Container()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        registerServices(container: container)
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        defer { self.window = window }
        
        window.windowScene = windowScene
        window.rootViewController = UINavigationController(rootViewController: container.resolve(HomeViewController.self)!)
        window.makeKeyAndVisible()
    }
    
    func registerServices(container: Swinject.Container) {
        container.autoregister(HomeViewController.self, initializer: HomeViewController.init)
    }
}
