//
//  AppDelegate.swift
//  AR Localizer View
//

import UIKit
import ARLocalizerView

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window!.rootViewController = ARViewController()
    window!.makeKeyAndVisible()

    return true
  }
}
