//
//  Coordinator.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import UIKit

class Coordinator: NSObject, UINavigationControllerDelegate {

    // MARK: - Properties

    public var didFinish: ((Coordinator) -> Void)?

    // MARK: -

    public var childCoordinators: [Coordinator] = []

    // MARK: - Methods

    open func start() {}

    // MARK: - Navigation

    public func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) { }

    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) { }

    // MARK: - Push and Popcoordinators

    public func pushCoordinator(_ coordinator: Coordinator) {
        // Install Handler
        coordinator.didFinish = { [weak self] coordinator in
            self?.popCoordinator(coordinator)
        }

        // Start Coordinator
        coordinator.start()

        // Append to Child Coordinators
        childCoordinators.append(coordinator)
    }

    public func popCoordinator(_ coordinator: Coordinator) {
        // Remove Coordinator From Child Coordinators
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
