//
//  SceneDelegate.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import UIKit

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var coordinator: MainCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigation = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigation)
        coordinator?.start()
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
