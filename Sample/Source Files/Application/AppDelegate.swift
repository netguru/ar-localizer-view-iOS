//
//  AppDelegate.swift
//  ARLocalizerView
//

import UIKit
import ARLocalizerView

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    lazy var coordinator: Coordinator = Coordinator(factory: Factory())

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
