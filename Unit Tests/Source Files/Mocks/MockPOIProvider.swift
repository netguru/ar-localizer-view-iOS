//
//  MockPOIProvider.swift
//  ARLocalizerView
//

import ARLocalizerView

class MockPOIProvider: POIProvider {
    var didSetLocationBounds: (() -> Void)?
    var pois: [POI] = []

    var locationBounds: LocationBounds? {
        didSet {
            didSetLocationBounds?()
        }
    }
}
