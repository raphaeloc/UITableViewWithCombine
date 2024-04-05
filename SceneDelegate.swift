//
//  SceneDelegate.swift
//  ChatbotListCombine
//
//  Created by Rapha on 26/03/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let vc = ListViewControllerContainer()
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
