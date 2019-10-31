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
    guard let fileURL = Bundle.main.url(forResource: "NetguruOffices", withExtension: "json") else { return true }

    let filePOIProvider = FilePOIProvider(fileURL: fileURL)
    let viewModel = ARViewModel(poiProvider: filePOIProvider)

    window = UIWindow(frame: UIScreen.main.bounds)
    window!.rootViewController = ARViewController(viewModel: viewModel)
    window!.makeKeyAndVisible()

    return true
  }
}
