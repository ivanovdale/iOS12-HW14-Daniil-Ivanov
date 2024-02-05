//
//  SceneDelegate.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let tabBarController = TabBarController()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

