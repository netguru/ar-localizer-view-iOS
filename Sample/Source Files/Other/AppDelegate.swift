//
//  AppDelegate.swift
//  ARLocalizerView
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  private var mainCoordinator: MainCoordinator?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    mainCoordinator = MainCoordinator(navigationController: UINavigationController(), factory: Factory())
    window?.rootViewController = mainCoordinator?.navigationController
    window?.makeKeyAndVisible()
    mainCoordinator?.start()

    return true
  }
}
