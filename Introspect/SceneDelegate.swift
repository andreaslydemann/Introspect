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
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController(rootViewController: container.resolve(ViewController.self)!)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func registerServices(container: Swinject.Container) {
        container.autoregister(ViewController.self, initializer: ViewController.init)
    }
}
