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
    SetupViewControllerDelegate,
    SignInViewControllerDelegate,
    AccountViewControllerDelegate {
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
        accountVC.delegate = self
        navigationController.pushViewController(accountVC, animated: true)
    }
    
    // MARK: - SignInViewControllerDelegate methods
    
    func signMessage(signature: String, message: String) {
        let signatureVC = SignatureViewController(message: message, signature: signature)
        navigationController.pushViewController(signatureVC, animated: true)
    }
    
    // MARK: - AccountViewControllerDelegate
    
    func signWasSelected(privateKey: EthereumPrivateKey) {
        let signinVC = SignInViewController(privateKey: privateKey)
        signinVC.title = "Sign"
        signinVC.delegate = self
        navigationController.pushViewController(signinVC, animated: true)
    }
    
    func verifyWasSelected() {
        
    }
}
