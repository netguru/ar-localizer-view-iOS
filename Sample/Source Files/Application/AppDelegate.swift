//
//  AppDelegate.swift
//  ARLocalizerView
//

import UIKit
import ARLocalizerView

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private var mainCoordinator: MainCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        mainCoordinator = MainCoordinator(factory: Factory())
        window?.rootViewController = mainCoordinator?.navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
