//
//  POIProvider.swift
//  ARLocalizerView
//

import Foundation

public typealias LocationBounds = (south: Double, west: Double, north: Double, east: Double)

public protocol POIProvider {
    var pois: [POI] { get }
    var didUpdate: (() -> Void)? { get set }
    var locationBounds: LocationBounds? { get set }
}

extension POIProvider {
    public var didUpdate: (() -> Void)? {
        get {
            return nil
        }
        set {
            _ = newValue
        }
    }
    public var locationBounds: LocationBounds? {
        get {
            return nil
        }
        set {
            _ = newValue
        }
    }
}
