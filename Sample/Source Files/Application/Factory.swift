//
//  Factory.swift
//  ARLocalizerView
//

import UIKit
import ARLocalizerView

final class Factory {
    private let fileProvider: FilePOIProvider = {
        guard let fileURL = Bundle.main.url(forResource: "NetguruOffices", withExtension: "json") else {
            fatalError("NetguruOffices.json not found in the bundle's resources.")
        }
        return FilePOIProvider(fileURL: fileURL)
    }()
    private let atmProvider = ATMProvider()
}

// MARK: - Functions

extension Factory {
    func arScreenController(delegate: ARScreenControllerDelegate) -> ARScreenController {
        return ARScreenController(arViewController: arViewController(), delegate: delegate)
    }

    func mapScreenController(delegate: MapScreenControllerDelegate) -> MapScreenController {
        return MapScreenController(poiProvider: atmProvider, delegate: delegate)
    }

    private func arViewController() -> ARViewController {
        return ARViewController(
            viewModel: ARViewModel(
                poiProvider: atmProvider
            )
        )
    }
}
