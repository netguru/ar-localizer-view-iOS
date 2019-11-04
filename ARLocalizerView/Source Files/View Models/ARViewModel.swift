//
//  ARViewModel.swift
//  ARLocalizerView
//

import UIKit
import CoreLocation

typealias Angle = Double

extension Angle {
  /// Calculates smallest difference between two angles.
  /// Returns positive value for clockwise rotation or negative for counterclockwise.
  func smallestDifference(to angle: Angle) -> Angle {
    let difference = self - angle

    if difference > 180 {
      return difference - 360
    } else if difference < -180 {
      return difference + 360
    } else {
      return difference
    }
  }
}

final public class ARViewModel: ARViewModelProtocol {
  // MARK: Public properties
  public var deviceHeading: CLHeading? {
    didSet {
      guard let deviceHeading = deviceHeading else { return }
      deviceAzimuth = deviceHeading.trueHeading
      deviceAzimuthAccuracy = deviceHeading.headingAccuracy
      updatePOILabelsProperties()
    }
  }
  public var deviceLocation: CLLocation? {
    didSet {
      updatePOILabelsProperties()
    }
  }
  public var pois: [POI] { poiLabelsProperties.map { $0.key } }

  // MARK: Private properties
  private(set) var poiLabelsProperties: [POI: POILabelProperties]
  private var deviceAzimuth: Angle
  private var deviceAzimuthAccuracy: Angle

  // MARK: Init
  public init(poiProvider: POIProvider) {
    var newPOILabelsProperties: [POI: POILabelProperties] = [:]

    poiProvider.pois.forEach {
      newPOILabelsProperties[$0] = POILabelProperties(xOffset: 0, yOffset: 0, text: "", isHidden: true)
    }

    poiLabelsProperties = newPOILabelsProperties
    deviceAzimuth = 0
    deviceAzimuthAccuracy = 0
  }

  // MARK: POI Label Methods
  private func updatePOILabelsProperties() {
    var newPOILabelsProperties: [POI: POILabelProperties] = [:]
    pois.forEach { newPOILabelsProperties[$0] = poiLabelProperties(forPOI: $0) }
    poiLabelsProperties = newPOILabelsProperties
  }

  private func poiLabelProperties(forPOI poi: POI) -> POILabelProperties {
    let azimuthForPOI = azimuth(forPOI: poi)
    let leftBound = minimalAngleOfVisibility(forAzimuth: azimuthForPOI)
    let rightBound = maximalAngleOfVisibility(forAzimuth: azimuthForPOI)
    let shouldBeVisible = isAngleInSector(deviceAzimuth, withLeftBound: leftBound, withRightBound: rightBound)
    let text = distanceText(forPOI: poi)
    let xOffset = labelXOffset(forAzimut: azimuthForPOI)

    return POILabelProperties(xOffset: xOffset, yOffset: 0, text: text, isHidden: !shouldBeVisible)
  }

  private func distanceText(forPOI poi: POI) -> String {
    guard let deviceLocation = deviceLocation else { return "" }
    let distanceToPOI = Int(poi.clLocation.distance(from: deviceLocation))
    return "\(distanceToPOI) m"
  }
}

// MARK: - Calulations
extension ARViewModel {
  private func azimuth(forPOI poi: POI) -> Angle {
    guard let currentLocation = deviceLocation else { return 0 }
    let dX = poi.latitude - currentLocation.coordinate.latitude
    let dY = poi.longitude - currentLocation.coordinate.longitude
    let tanPhi = Float(abs(dY / dX))
    let phiAngle = Angle(atan(tanPhi) * 180 / .pi)

    if dX < 0 && dY > 0 {
      return 180 - phiAngle
    } else if dX < 0 && dY < 0 {
      return 180 + phiAngle
    } else if dX > 0 && dY < 0 {
      return 360 - phiAngle
    } else {
      return phiAngle
    }
  }

  private func minimalAngleOfVisibility(forAzimuth azimuth: Angle) -> Angle {
    var angle = azimuth - deviceAzimuthAccuracy - 15
    if angle < 0 {
      angle += 360
    }
    return angle
  }

  private func maximalAngleOfVisibility(forAzimuth azimuth: Angle) -> Angle {
    var angle = azimuth + deviceAzimuthAccuracy + 15
    if angle >= 360 {
      angle -= 360
    }
    return angle
  }

  private func isAngleInSector(
    _ angle: Angle,
    withLeftBound leftBound: Angle,
    withRightBound rightBound: Angle
  ) -> Bool {
    if leftBound > rightBound {
      return  (leftBound...360).contains(angle) || (0...rightBound).contains(angle)
    } else {
      return  angle >= leftBound && angle <= rightBound
    }
  }

  private func labelXOffset(forAzimut azimutToPOI: Angle) -> CGFloat {
    let pixelsForOneDegree = Double(UIScreen.main.bounds.width / 30.0)
    let offsetInDegrees = azimutToPOI.smallestDifference(to: deviceAzimuth)
    let offsetInPixels = offsetInDegrees * pixelsForOneDegree
    return CGFloat(offsetInPixels)
  }
}
