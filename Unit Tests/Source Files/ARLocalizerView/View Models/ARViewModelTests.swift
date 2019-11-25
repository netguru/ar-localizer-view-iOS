//
//  ARViewModelTests.swift
//  ARLocalizerView
//

import XCTest
import CoreLocation
@testable import ARLocalizerView

class ARViewModelTests: XCTestCase {
    let examplePOI = POI(name: "netguru-HQ", latitude: 52.4015279, longitude: 16.8918892)
    let examplePOILabelProperties = POILabelProperties(
        xOffset: -72.46556908927708,
        yOffset: 288.46153846153845,
        name: "netguru-HQ",
        distance: 280190.62833363726,
        isHidden: false
    )

    var arViewModel: ARViewModel!

    override func setUp() {
        super.setUp()
        arViewModel = ARViewModel(poiProvider: nil)
        arViewModel.deviceAzimuth = 280
        arViewModel.deviceLocation = CLLocation(latitude: 52.2389356, longitude: 20.9930279)
        arViewModel.deviceGravityZ = 0.5
    }

    // MARK: - Test Methods
    func testAzimuthForPOI() {
        XCTAssertEqual(
            arViewModel.azimuth(forPOI: examplePOI),
            272.2703392971438,
            "Azimuth for example POI should equal 272.2703392971438."
        )
    }

    func testPOILabelPropertiesGeneration() {
        let properties = arViewModel.poiLabelProperties(forPOI: examplePOI)
        XCTAssertEqual(
            properties.distance,
            examplePOILabelProperties.distance,
            "Distance property generated for example POI should equal example distance property."
        )
        XCTAssertEqual(
            properties.name,
            examplePOILabelProperties.name,
            "Name property generated for example POI should equal example name property."
        )
        XCTAssertEqual(
            properties.isHidden,
            examplePOILabelProperties.isHidden,
            "isHidden property generated for example POI should equal example isHidden property."
        )
    }

    func testSetupPOILabelsProperties() {
        XCTAssertEqual(arViewModel.poiLabelsProperties.count, 0, "Initialy there should be 0 label property sets.")
        arViewModel.setupPOILabels(forPOIs: [examplePOI])
        XCTAssertEqual(arViewModel.poiLabelsProperties.count, 1, "There should be exactly 1 label property set.")
    }

    func testPOIsArray() {
        XCTAssertEqual(arViewModel.pois.count, 0, "Initialy there should be 0 POIs in view model.")
        arViewModel.poiLabelsProperties[examplePOI] = examplePOILabelProperties
        XCTAssertEqual(arViewModel.pois.count, 1, "There should be exactly one POI in view model.")
        XCTAssertEqual(arViewModel.pois.first, examplePOI, "The only POI in view model should be example POI.")
    }

    func testUpdatePOILabelsProperties() {
        arViewModel.deviceLocation = CLLocation(latitude: 50, longitude: 18)
        arViewModel.updatePOILabelsProperties()

        let properties = arViewModel.poiLabelProperties(forPOI: examplePOI)
        XCTAssertNotEqual(
            properties.distance,
            examplePOILabelProperties.distance,
            "Distance property generated for latitude = 50 and longitude = 18 should equal example distance property."
        )
        XCTAssertNotEqual(
            properties.isHidden,
            examplePOILabelProperties.isHidden,
            "isHidden property generated for latitude = 50 and longitude = 18 should equal example isHidden property."
        )
    }

    func testAdjustingAngleBasedOnCoordinateSystemQuarter() {
        let angle: Angle = 45
        let angleInFirstQuarter = arViewModel.angleAdjustedBasedOnCoordinateSystemQuarter(
            angle: angle,
            isXPositive: true,
            isYPositive: true
        )
        XCTAssertEqual(angleInFirstQuarter, 45, "In first quarter of coordinate system 45 angle should equal 45.")

        let angleInSecondQuarter = arViewModel.angleAdjustedBasedOnCoordinateSystemQuarter(
            angle: angle,
            isXPositive: false,
            isYPositive: true
        )
        XCTAssertEqual(angleInSecondQuarter, 135, "In second quarter of coordinate system 45 angle should equal 135.")

        let angleInThirdQuarter = arViewModel.angleAdjustedBasedOnCoordinateSystemQuarter(
            angle: angle,
            isXPositive: false,
            isYPositive: false
        )
        XCTAssertEqual(angleInThirdQuarter, 225, "In third quarter of coordinate system 45 angle should equal 225.")

        let angleInForthQuarter = arViewModel.angleAdjustedBasedOnCoordinateSystemQuarter(
            angle: angle,
            isXPositive: true,
            isYPositive: false
        )
        XCTAssertEqual(angleInForthQuarter, 315, "In fourth quarter of coordinate system 45 angle should equal 315.")
    }
}
