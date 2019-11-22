//
//  Coordinator.swift
//  ARLocalizerView
//

import UIKit

final class Coordinator {
    let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        return navigationController
    }()

    private let factory: Factory

    init(factory: Factory) {
        self.factory = factory
        navigationController.pushViewController(factory.mapScreenController(delegate: self), animated: false)
    }
}

extension Coordinator: MapScreenViewControllerDelegate {
    func didTapOnARViewButton() {
        navigationController.pushViewController(factory.arScreenController(delegate: self), animated: true)
    }
}

extension Coordinator: ARScreenViewControllerDelegate {
    func didTapOnMapViewButton(arScreenController: ARScreenViewController) {
        navigationController.popViewController(animated: true)
    }
}
