//
//  ARViewModelProtocol.swift
//  ARLocalizerView
//

import UIKit
import CoreLocation

public protocol ARViewModelProtocol {
  var deviceHeading: CLHeading? { get set }
  var deviceLocation: CLLocation? { get set }
  var pois: [POI] { get }
}
