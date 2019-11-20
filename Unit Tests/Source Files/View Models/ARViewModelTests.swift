//
//  ARViewModelTests.swift
//  ARLocalizerView
//

import XCTest
import CoreLocation
@testable import ARLocalizerView

class ARViewModelTests: XCTestCase {
    // MARK: - Objects
    let arViewModel: ARViewModel = {
        let arViewModel = ARViewModel(poiProvider: nil)
        arViewModel.deviceAzimuth = 280
        arViewModel.deviceLocation = CLLocation(latitude: 52.2389356, longitude: 20.9930279)
        arViewModel.deviceGravityZ = 0.5
        return arViewModel
    }()

    let poi = POI(name: "netguru-HQ", latitude: 52.4015279, longitude: 16.8918892)

    let poiLabelProperties = POILabelProperties(
        xOffset: -72.46556908927708,
        yOffset: 288.46153846153845,
        name: "netguru-HQ",
        distance: 280190.62833363726,
        isHidden: false
    )

    // MARK: - Test Methods
    func testAzimuthForPOI() {
        XCTAssertEqual(arViewModel.azimuth(forPOI: poi), 272.2703392971438)
    }

    func testPOILabelPropertiesGeneration() {
        let properties = arViewModel.poiLabelProperties(forPOI: poi)
        XCTAssertEqual(properties, poiLabelProperties)
    }

    func testSetupPOILabelsProperties() {
        XCTAssertEqual(arViewModel.poiLabelsProperties.count, 0)
        arViewModel.setupPOILabels(forPOIs: [poi])
        XCTAssertEqual(arViewModel.poiLabelsProperties.count, 1)
        arViewModel.poiLabelsProperties.removeAll()
    }

    func testPOIsArray() {
        XCTAssertEqual(arViewModel.pois.count, 0)
        arViewModel.poiLabelsProperties[poi] = poiLabelProperties
        XCTAssertEqual(arViewModel.pois.first, poi)
    }

    func testUpdatePOILabelsProperties() {
        arViewModel.poiLabelsProperties[poi] = poiLabelProperties
        arViewModel.deviceLocation = CLLocation(latitude: 50, longitude: 18)
        arViewModel.updatePOILabelsProperties()
        XCTAssertNotEqual(arViewModel.poiLabelsProperties[poi], poiLabelProperties)
    }

    func testAdjustingAngleBasedOnCoordinateSystemQuarter() {
        let angle: Angle = 45
        let angleInFirstQuarter = arViewModel.angleAdjustedBasedOnCoordinateSystemQuarter(
            angle: angle,
            isXPositive: true,
            isYPositive: true
        )
        XCTAssertEqual(angleInFirstQuarter, 45)

        let angleInSecondQuarter = arViewModel.angleAdjustedBasedOnCoordinateSystemQuarter(
            angle: angle,
            isXPositive: false,
            isYPositive: true
        )
        XCTAssertEqual(angleInSecondQuarter, 135)

        let angleInThirdQuarter = arViewModel.angleAdjustedBasedOnCoordinateSystemQuarter(
            angle: angle,
            isXPositive: false,
            isYPositive: false
        )
        XCTAssertEqual(angleInThirdQuarter, 225)

        let angleInForthQuarter = arViewModel.angleAdjustedBasedOnCoordinateSystemQuarter(
            angle: angle,
            isXPositive: true,
            isYPositive: false
        )
        XCTAssertEqual(angleInForthQuarter, 315)
    }
}
