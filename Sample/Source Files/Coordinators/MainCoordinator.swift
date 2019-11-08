//
//  MainCoordinator.swift
//  ARLocalizerView
//

import UIKit

final class MainCoordinator: Coordinator {
    let navigationController: UINavigationController = UINavigationController()
    let factory: Factory

    var childCoordinators: [Coordinator] = []

    init(factory: Factory) {
        self.factory = factory
        let initialViewController = factory.arViewController()
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(initialViewController, animated: true)
    }
}
