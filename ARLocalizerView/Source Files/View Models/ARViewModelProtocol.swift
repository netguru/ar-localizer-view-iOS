//
//  ARViewModelProtocol.swift
//  ARLocalizerView
//

import UIKit
import CoreLocation

public protocol ARViewModelProtocol {
    var deviceLocation: CLLocation? { get set }
    var deviceAzimuth: Angle { get set }
    var deviceAzimuthAccuracy: Angle { get set }
    var deviceGravityZ: Double { get set }
    var pois: [POI] { get }
    var poiLabelsProperties: [POI: POILabelProperties] { get }

    func updatePOILabelsProperties()
}
