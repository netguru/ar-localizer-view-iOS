//
//  ARViewModel.swift
//  ARLocalizerView
//

import UIKit
import CoreLocation

final public class ARViewModel: ARViewModelProtocol {
    // MARK: Public properties
    public var deviceLocation: CLLocation?
    public var deviceAzimuth: Angle
    public var deviceAzimuthAccuracy: Angle
    public var deviceGravityZ: Double
    public var poiLabelsProperties: [POI: POILabelProperties]
    public var pois: [POI] {
        poiLabelsProperties.map { $0.key }
    }

    // MARK: Private properties
    private var labelsYOffset: CGFloat {
        let offsetInPixels = CGFloat(deviceGravityZ) * UIScreen.main.pixelsForOneHoundrethOfGravity * 100.0
        return offsetInPixels
    }

    // MARK: Init
    public init(poiProvider: POIProvider) {
        var newPOILabelsProperties: [POI: POILabelProperties] = [:]

        poiProvider.pois.forEach {
            newPOILabelsProperties[$0] = POILabelProperties(xOffset: 0, yOffset: 0, text: "", isHidden: true)
        }

        poiLabelsProperties = newPOILabelsProperties
        deviceAzimuth = 0
        deviceAzimuthAccuracy = 0
        deviceGravityZ = 0
    }

    // MARK: POI Label Methods
    public func updatePOILabelsProperties() {
        pois.forEach {
            poiLabelsProperties[$0] = poiLabelProperties(forPOI: $0)
        }
    }

    private func poiLabelProperties(forPOI poi: POI) -> POILabelProperties {
        let azimuthForPOI = azimuth(forPOI: poi)
        let leftBound = minimalAngleOfVisibility(forAzimuth: azimuthForPOI)
        let rightBound = maximalAngleOfVisibility(forAzimuth: azimuthForPOI)

        return POILabelProperties(
            xOffset: labelXOffset(forAzimut: azimuthForPOI),
            yOffset: labelsYOffset,
            text: distanceText(forPOI: poi),
            isHidden: !isAngleInSector(deviceAzimuth, withLeftBound: leftBound, withRightBound: rightBound)
        )
    }

    private func distanceText(forPOI poi: POI) -> String {
        guard let deviceLocation = deviceLocation else { fatalError("No device location data.") }
        let distanceToPOI = Int(poi.clLocation.distance(from: deviceLocation))
        return "\(distanceToPOI) m"
    }
}

// MARK: - Calulations
private extension ARViewModel {
    func azimuth(forPOI poi: POI) -> Angle {
        guard let deviceLocation = deviceLocation else { fatalError("No device location data.") }
        let dX = poi.latitude - deviceLocation.coordinate.latitude
        let dY = poi.longitude - deviceLocation.coordinate.longitude
        let tanPhi = abs(dY / dX)
        let phiAngle = AngleConverter.shared.convertToDegrees(radians: atan(tanPhi))

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

    func minimalAngleOfVisibility(forAzimuth azimuth: Angle) -> Angle {
        var angle = azimuth - deviceAzimuthAccuracy - 15
        if angle < 0 {
            angle += 360
        }
        return angle
    }

    func maximalAngleOfVisibility(forAzimuth azimuth: Angle) -> Angle {
        var angle = azimuth + deviceAzimuthAccuracy + 15
        if angle >= 360 {
            angle -= 360
        }
        return angle
    }

    func isAngleInSector(
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
        let offsetInPixels = CGFloat(offsetInDegrees) * UIScreen.main.pixelsForOneDegree
        return offsetInPixels
    }
}
