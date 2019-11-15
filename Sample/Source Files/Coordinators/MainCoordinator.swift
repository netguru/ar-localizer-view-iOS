//
//  MainCoordinator.swift
//  ARLocalizerView
//

import UIKit

final class MainCoordinator: Coordinator {
    let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        return navigationController
    }()
    var childCoordinators: [Coordinator] = []

    private let factory: Factory

    init(factory: Factory) {
        self.factory = factory
        navigationController.pushViewController(factory.mapScreenController(delegate: self), animated: false)
    }
}

extension MainCoordinator: MapScreenControllerDelegate {
    func didTapOnARViewButton() {
        let arScreenCoordinator = ARScreenCoordinator(
            navigationController: navigationController,
            factory: factory
        )
        arScreenCoordinator.didDismiss = { [weak self] in
            self?.removeChild(coordinator: arScreenCoordinator)
        }
        addChild(coordinator: arScreenCoordinator)
    }
}
