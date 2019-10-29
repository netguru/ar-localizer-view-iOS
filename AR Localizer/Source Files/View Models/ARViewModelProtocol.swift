//
//  ARViewModelProtocol.swift
//  AR Localizer
//

import UIKit
import CoreLocation

protocol ARViewModelProtocol {
  var heading: CLHeading? { get set }
  var currentLocation: CLLocation? { get set }
  var distanceLabelXOffset: CGFloat { get }
  var distanceLabelText: String { get }
  var distanceLabelIsHidden: Bool { get }
  var azimuthToNorthLabelText: String { get }
  var azimuthToTargetLocationLabelText: String { get }
}
