//
//  POITests.swift
//  ARLocalizerView
//

import XCTest
import CoreLocation
@testable import ARLocalizerView

class POITests: XCTestCase {
    let poi = POI(name: "netguru-HQ", latitude: 52.4015279, longitude: 16.8918892)

    func testInit() {
        XCTAssertEqual(poi.name, "netguru-HQ")
        XCTAssertEqual(poi.latitude, 52.4015279)
        XCTAssertEqual(poi.longitude, 16.8918892)
    }

    func testCLLocation() {
        let clLocation = CLLocation(latitude: 52.4015279, longitude: 16.8918892)
        XCTAssertEqual(clLocation.distance(from: poi.clLocation), 0)
    }

    func testMKAnnotationTitle() {
        XCTAssertEqual(poi.title, "netguru-HQ")
    }

    func testMKAnnotationCoordiante() {
        XCTAssertEqual(poi.coordinate.latitude, 52.4015279)
        XCTAssertEqual(poi.coordinate.longitude, 16.8918892)
    }
}
