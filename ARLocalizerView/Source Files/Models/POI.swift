//
//  POI.swift
//  ARLocalizerView
//

import Foundation
import CoreLocation

public struct POI: Decodable, Hashable {
  var latitude: Double
  var longitude: Double
  var clLocation: CLLocation { CLLocation(latitude: latitude, longitude: longitude) }
}
