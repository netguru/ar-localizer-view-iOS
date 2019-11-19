//
//  POIProvider.swift
//  ARLocalizerView
//

import Foundation

public typealias LocationBounds = (south: Angle, west: Angle, north: Angle, east: Angle)

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
