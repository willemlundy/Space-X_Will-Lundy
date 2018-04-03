//
//  ApplicationCoordinator.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    let launchCoordinator: LaunchCoordinator
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.launchCoordinator = LaunchCoordinator(presenter: rootViewController)
    }
    
    func start() {
        self.window.rootViewController = rootViewController
        self.launchCoordinator.start()
        self.window.makeKeyAndVisible()
    }
    
}
