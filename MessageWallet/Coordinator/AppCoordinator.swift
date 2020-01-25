//
//  AppCoordinator.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import UIKit
import Web3

class AppCoordinator: Coordinator,
    SetupViewControllerDelegate {
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
        setupVC.delegate = self
        navigationController.pushViewController(setupVC, animated: false)
    }
    
    // MARK: - SetupViewControllerDelegate methods
    
    func privateKeyWasSuccesful(withPrivateKey key: EthereumPrivateKey) {
        let accountVC = AccountViewController(privateKey: key)
        navigationController.pushViewController(accountVC, animated: true)
    }
}
