//
//  POI.swift
//  ARLocalizerView
//

import Foundation
import CoreLocation
import MapKit

public final class POI: NSObject, Decodable {
    var latitude: Double
    var longitude: Double
    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension POI: MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return clLocation.coordinate
    }
}
