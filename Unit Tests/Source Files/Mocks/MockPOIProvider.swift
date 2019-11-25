//
//  MockPOIProvider.swift
//  ARLocalizerView
//

import ARLocalizerView

class MockPOIProvider: POIProvider {
    var didSetLocationBounds: (() -> Void)?
    var pois: [POI] = [] {
        didSet {

        }
    }

    var locationBounds: LocationBounds? {
        didSet {
            didSetLocationBounds?()
        }
    }
}
