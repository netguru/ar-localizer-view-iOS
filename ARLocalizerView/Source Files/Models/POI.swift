//
//  POI.swift
//  ARLocalizerView
//

import Foundation
import CoreLocation
import MapKit

public final class POI: NSObject, Decodable {
    public var name: String?
    var latitude: Double
    var longitude: Double
    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

    public init(name: String? = nil, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension POI: MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return clLocation.coordinate
    }
}
