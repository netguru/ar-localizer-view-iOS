//
//  POITests.swift
//  ARLocalizerView
//

import XCTest
import CoreLocation
@testable import ARLocalizerView

class POITests: XCTestCase {
    let examplePOI = POI(name: "netguru-HQ", latitude: 52.4015279, longitude: 16.8918892)

    func testCLLocation() {
        let clLocation = CLLocation(latitude: 52.4015279, longitude: 16.8918892)
        XCTAssertEqual(
            clLocation.distance(from: examplePOI.clLocation),
            0,
            "Distance between POI's clLocation and a CLLocation constructed using the same coordinates should be 0."
        )
    }

    func testMKAnnotationTitle() {
        XCTAssertEqual(
            examplePOI.title,
            "netguru-HQ",
            "Annotation's title should be equal to POI's name."
        )
    }

    func testMKAnnotationCoordinate() {
        XCTAssertEqual(
            examplePOI.coordinate.latitude,
            52.4015279,
            "Annotation's latitude should be equal to POI's."
        )
        XCTAssertEqual(
            examplePOI.coordinate.longitude,
            16.8918892,
            "Annotation's longitude should be equal to POI's."
        )
    }
}
