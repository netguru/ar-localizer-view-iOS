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

    private let atmProvider = OverpassATMProvider(
        networkClient: OverpassATMNetworkClient(),
        poiExtractor: OverpassATMExtractor()
    )
}

// MARK: - Functions

extension Factory {
    func arScreenController(delegate: ARScreenViewControllerDelegate) -> ARScreenViewController {
        return ARScreenViewController(
            arViewController: ARViewController(
                viewModel: ARViewModel(
                    poiProvider: atmProvider
                ),
                poiLabelViewType: ATMLabelView.self
            ),
            delegate: delegate
        )
    }

    func mapScreenController(delegate: MapScreenViewControllerDelegate) -> MapScreenViewController {
        return MapScreenViewController(poiProvider: atmProvider, delegate: delegate)
    }
}
