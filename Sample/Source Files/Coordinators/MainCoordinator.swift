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

extension MainCoordinator: MapScreenViewControllerDelegate {
    func didTapOnARViewButton() {
        navigationController.pushViewController(factory.arScreenController(delegate: self), animated: true)
    }
}

extension MainCoordinator: ARScreenViewControllerDelegate {
    func didTapOnMapViewButton(arScreenController: ARScreenViewController) {
        navigationController.popViewController(animated: true)
    }
}
