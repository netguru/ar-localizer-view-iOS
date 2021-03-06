//
//  MainCoordinator.swift
//  ARLocalizerView
//

import UIKit

final class ARScreenCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var didDismiss: (() -> Void)?

    private let factory: Factory

    init(navigationController: UINavigationController, factory: Factory) {
        self.navigationController = navigationController
        self.factory = factory
        navigationController.pushViewController(factory.arScreenController(delegate: self), animated: true)
    }
}

extension ARScreenCoordinator: ARScreenViewControllerDelegate {
    func didTapOnMapViewButton(arScreenController: ARScreenViewController) {
        navigationController.popViewController(animated: true)
        didDismiss?()
    }
}
