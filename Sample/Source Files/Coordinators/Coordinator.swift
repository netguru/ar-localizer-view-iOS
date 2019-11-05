//
//  Coordinator.swift
//  ARLocalizerView
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
    func addChild(coordinator: Coordinator) {
        guard !isCoordinatorAChild(coordinator: coordinator) else { return }
        childCoordinators.append(coordinator)
    }

    func removeChild(coordinator: Coordinator) {
        guard isCoordinatorAChild(coordinator: coordinator) else { return }
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    private func isCoordinatorAChild(coordinator: Coordinator) -> Bool {
        return childCoordinators.contains { $0 === coordinator }
    }
}
