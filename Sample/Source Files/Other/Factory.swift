//
//  Factory.swift
//  Sample
//

import UIKit
import ARLocalizerView

final class Factory {
    private let poiProvider: FilePOIProvider = {
        guard let fileURL = Bundle.main.url(forResource: "NetguruOffices", withExtension: "json") else {
            fatalError("NetguruOffices.json not found in the bundle's resources.")
        }
        return FilePOIProvider(fileURL: fileURL)
    }()
}

// MARK: - Functions

extension Factory {
    func arViewController() -> ARViewController {
        return ARViewController(
            viewModel: ARViewModel(
                poiProvider: poiProvider
            )
        )
    }
}
