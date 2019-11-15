//
//  ATMProvider.swift
//  ARLocalizerView
//

import Foundation
import ARLocalizerView

final class ATMProvider: POIProvider {
    var didUpdate: (() -> Void)?
    var locationBounds: LocationBounds? {
        didSet {
            guard let locationBounds = locationBounds else { return }
            atmNetworkClient.getData(usingAttributes: locationBounds) { [weak self] data, networkError in
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
    private(set) var pois: [POI] = [] {
        didSet {
            didUpdate?()
        }
    }
    private let atmNetworkClient = ATMNetworkClient()
    private let poiExtractor = POIExtractor()
}
