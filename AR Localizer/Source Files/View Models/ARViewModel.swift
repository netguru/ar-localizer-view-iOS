//
//  ARViewModel.swift
//  AR Localizer
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

final class ARViewModel: ARViewModelProtocol {

  // MARK: Public properties

  var heading: CLHeading? {
    didSet {
      guard let heading = heading else { return }
      azimuthToNorth = heading.trueHeading
      azimuthToNorthAccuracy = heading.headingAccuracy
      updateDistanceLabelOffsetAndVisibility()
    }
  }

  var currentLocation: CLLocation? {
    didSet {
      guard let currentLocation = currentLocation else { return }
      azimuthToTargetLocation = calculateAzimuth(from: currentLocation, to: targetLocation)
      updateDistanceLabelText(currentLocation: currentLocation)
      updateDistanceLabelOffsetAndVisibility()
    }
  }

  // MARK: View mapping properties

  private(set) var distanceLabelXOffset = CGFloat(0.0)
  private(set) var distanceLabelText = ""
  private(set) var distanceLabelIsHidden = true
  private(set) var azimuthToNorthLabelText = ""
  private(set) var azimuthToTargetLocationLabelText = ""

  // MARK: Private properties

  private let targetLocation: CLLocation

  private var azimuthToNorth: Angle = 0 {
    didSet {
      azimuthToNorthLabelText = "Azimuth to North: \(Int(azimuthToNorth))"
    }
  }

  private var azimuthToTargetLocation: Angle = 0 {
    didSet {
      azimuthToTargetLocationLabelText = "Azimuth to Target Location: \(Int(azimuthToTargetLocation))"
    }
  }

  private var azimuthToNorthAccuracy: Angle = 0

  private var minimalAngleOfVisibility: Double {
    var angle = azimuthToTargetLocation - azimuthToNorthAccuracy - 15
    if angle < 0 {
      angle += 360
    }
    return angle
  }

  private var maximalAngleOfVisibilty: Double {
    var angle = azimuthToTargetLocation + azimuthToNorthAccuracy + 15
    if angle >= 360 {
      angle -= 360
    }
    return angle
  }

  // MARK: Init

  init(targetLocation: CLLocation) {
    self.targetLocation = targetLocation
  }

  // MARK: Update view mapping properties

  private func updateDistanceLabelText(currentLocation: CLLocation) {
    let distanceToTargetLocation = targetLocation.distance(from: currentLocation)
    distanceLabelText = "\(Int(distanceToTargetLocation)) m"
  }

  private func updateDistanceLabelOffsetAndVisibility() {
    let shouldBeVisible = isAngleInSector(
      azimuthToNorth,
      withLeftBound: minimalAngleOfVisibility,
      withRightBound: maximalAngleOfVisibilty
      )
    if shouldBeVisible {
      calculateDistanceLabelXOffset()
      distanceLabelIsHidden = false
    } else {
      distanceLabelIsHidden = true
    }
  }
}

// MARK: - Calulations

extension ARViewModel {
  private func calculateDistanceLabelXOffset() {
    let pixelsForOneDegree = Double(UIScreen.main.bounds.width / 30.0)
    let offsetInDegrees = azimuthToTargetLocation.smallestDifference(to: azimuthToNorth)
    let offsetInPixels = offsetInDegrees * pixelsForOneDegree
    distanceLabelXOffset = CGFloat(offsetInPixels)
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

  private func calculateAzimuth(from origin: CLLocation, to destination: CLLocation) -> Angle {
    let dX = destination.coordinate.latitude - origin.coordinate.latitude
    let dY = destination.coordinate.longitude - origin.coordinate.longitude
    let tanPhi = Float(abs(dY / dX))
    let phiAngle = Angle(atan(tanPhi) * 180 / .pi)

    if dX < 0 && dY > 0 {
      return 180 - phiAngle
    } else if dX < 0 && dY < 0 {
      return 180 + phiAngle
    } else if dX > 0 && dY < 0 {
      return 360 - phiAngle
    }

    return phiAngle
  }
}
