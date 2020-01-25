//
//  AppCoordinator.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    public var rootViewController: UIViewController {
        return navigationController
    }

    private let navigationController: UINavigationController

    public init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let setupVC = SetupViewController()
        setupVC.title = "Setup"
        navigationController.pushViewController(setupVC, animated: false)
    }
}
