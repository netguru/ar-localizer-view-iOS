//
//  POIProvider.swift
//  ARLocalizerView
//

import CoreLocation

public struct POI: Decodable, Hashable {
  var latitude: Double
  var longitude: Double
  var clLocation: CLLocation { CLLocation(latitude: latitude, longitude: longitude) }
}

public protocol POIProvider {
  var pois: [POI] { get set }
}
