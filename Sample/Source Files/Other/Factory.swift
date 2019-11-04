//
//  Factory.swift
//  Sample
//

import UIKit
import ARLocalizerView

final class Factory {
  private let poiProvider: FilePOIProvider

  init() {
    if let fileURL = Bundle.main.url(forResource: "NetguruOffices", withExtension: "json") {
      poiProvider = FilePOIProvider(fileURL: fileURL)
    } else {
      fatalError("NetguruOffices.json not found in the bundle's resources.")
    }
  }

  func arViewController() -> ARViewController {
    let viewModel = ARViewModel(poiProvider: poiProvider)
    let viewController = ARViewController(viewModel: viewModel)
    return viewController
  }
}
