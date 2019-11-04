//
//  MainCoordinator.swift
//  ARLocalizerView
//

import UIKit

final class MainCoordinator: Coordinator {
  let navigationController: UINavigationController
  let factory: Factory

  var childCoordinators: [Coordinator] = []

  init(navigationController: UINavigationController, factory: Factory) {
    self.navigationController = navigationController
    self.factory = factory
  }

  func start() {
    let initialViewController = factory.arViewController()
    navigationController.pushViewController(initialViewController, animated: true)
  }
}
