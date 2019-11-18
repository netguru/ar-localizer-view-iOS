//
//  OverpassATMProvider.swift
//  ARLocalizerView
//

import Foundation
import ARLocalizerView

final class OverpassATMProvider: POIProvider {
    var didUpdate: (() -> Void)?
    var locationBounds: LocationBounds? {
        didSet {
            updateAndGetData()
        }
    }

    private(set) var pois: [POI] = [] {
        didSet {
            didUpdate?()
        }
    }

    private let networkClient: OverpassATMNetworkClient
    private let poiExtractor: POIExtractor

    init(networkClient: OverpassATMNetworkClient, poiExtractor: POIExtractor) {
        self.networkClient = networkClient
        self.poiExtractor = poiExtractor
    }

    func updateAndGetData() {
        guard let locationBounds = locationBounds else {
            return
        }
        networkClient.getData(usingAttributes: locationBounds) { [weak self] data, networkError in
            if let networkError = networkError {
                print(networkError.description)
                return
            }
            guard let data = data else {
                print("Error: No Data")
                return
            }
            self?.poiExtractor.extractPOIs(fromXMLData: data) { [weak self] pois in
                self?.pois = pois
            }
        }
    }
}
