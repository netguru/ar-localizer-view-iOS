//
//  ARViewModel.swift
//  ARLocalizerView
//

import UIKit
import CoreLocation

final public class ARViewModel: ARViewModelProtocol {
    // MARK: Constants
    private enum Constants {
        /// Number of pixels on screen to represent every degree of azimuthal angle.
        /// It is used to calculate the change in AR label's horizontal offset when user moves the phone horizontally.
        static let pixelsForOneDegree = UIScreen.main.bounds.width / 40.0

        /// Number of pixels on screen to represent every 1/100th of gravitational force.
        /// It is used to calculate the change in AR label's vertical offset when user tilts.
        static let pixelsForOneHoundrethOfGravity = UIScreen.main.bounds.width / 65.0
        static let visibilityMargin: Angle = 40.0
    }

    // MARK: Public properties
    public var deviceLocation: CLLocation?
    public var deviceAzimuth: Angle = 0
    public var deviceAzimuthAccuracy: Angle = 0
    public var deviceGravityZ: Double = 0
    public var poiLabelsProperties: [POI: POILabelProperties] = [:]
    public var pois: [POI] {
        poiLabelsProperties.map { $0.key }
    }

    // MARK: Private properties
    private var labelsYOffset: CGFloat {
        let offsetInPixels = CGFloat(deviceGravityZ) * Constants.pixelsForOneHoundrethOfGravity * 100.0
        return offsetInPixels
    }

    // MARK: Init
    public init(poiProvider: POIProvider?) {
        setupPOILabels(forPOIs: poiProvider?.pois)
    }

    // MARK: POI Label Methods
    internal func setupPOILabels(forPOIs pois: [POI]?) {
        pois?.forEach {
            poiLabelsProperties[$0] = POILabelProperties(
                xOffset: 0,
                yOffset: 0,
                name: nil,
                distance: 0,
                isHidden: true
            )
        }
    }
    public func updatePOILabelsProperties() {
        pois.forEach {
            poiLabelsProperties[$0] = poiLabelProperties(forPOI: $0)
        }
    }

    internal func poiLabelProperties(forPOI poi: POI) -> POILabelProperties {
        let azimuthForPOI = azimuth(forPOI: poi)
        let leftBound = minimalAngleOfVisibility(forAzimuth: azimuthForPOI)
        let rightBound = maximalAngleOfVisibility(forAzimuth: azimuthForPOI)

        return POILabelProperties(
            xOffset: labelXOffset(forAzimut: azimuthForPOI),
            yOffset: labelsYOffset,
            name: poi.name,
            distance: distance(toPOI: poi),
            isHidden: !isAngleInSector(deviceAzimuth, withLeftBound: leftBound, withRightBound: rightBound)
        )
    }
}

// MARK: - Calulations
extension ARViewModel {
    func azimuth(forPOI poi: POI) -> Angle {
        guard let deviceLocation = deviceLocation else { return 0 }
        let x = poi.latitude - deviceLocation.coordinate.latitude
        let y = poi.longitude - deviceLocation.coordinate.longitude
        let tanPhi = abs(y / x)
        let phiAngle = AngleConverter.convertToDegrees(radians: atan(tanPhi))

        return angleAdjustedBasedOnCoordinateSystemQuarter(angle: phiAngle, isXPositive: x > 0, isYPositive: y > 0)
    }

    func angleAdjustedBasedOnCoordinateSystemQuarter(angle: Angle, isXPositive: Bool, isYPositive: Bool) -> Angle {
        switch (isXPositive, isYPositive) {
        // First quarter
        case (true, true):
            return angle
        // Second quarter
        case (false, true):
            return 180 - angle
        // Third quarter
        case (false, false):
            return 180 + angle
        // Fourth quarter
        case (true, false):
            return 360 - angle
        }
    }

    private func distance(toPOI poi: POI) -> Double {
        guard let deviceLocation = deviceLocation else { return 0 }
        return poi.clLocation.distance(from: deviceLocation)
    }

    private func minimalAngleOfVisibility(forAzimuth azimuth: Angle) -> Angle {
        var angle = azimuth - deviceAzimuthAccuracy - Constants.visibilityMargin
        while angle < 0 {
            angle += 360
        }
        return angle
    }

    private func maximalAngleOfVisibility(forAzimuth azimuth: Angle) -> Angle {
        var angle = azimuth + deviceAzimuthAccuracy + Constants.visibilityMargin
        while angle >= 360 {
            angle -= 360
        }
        return angle
    }

    internal func isAngleInSector(
        _ angle: Angle, withLeftBound leftBound: Angle, withRightBound rightBound: Angle
    ) -> Bool {
        if leftBound > rightBound {
            return (leftBound...360).contains(angle) || (0...rightBound).contains(angle)
        } else {
            return angle >= leftBound && angle <= rightBound
        }
    }

    private func labelXOffset(forAzimut azimutForPOI: Angle) -> CGFloat {
        let offsetInDegrees = azimutForPOI.smallestDifference(to: deviceAzimuth)
        let offsetInPixels = CGFloat(offsetInDegrees) * Constants.pixelsForOneDegree
        return offsetInPixels
    }
}
