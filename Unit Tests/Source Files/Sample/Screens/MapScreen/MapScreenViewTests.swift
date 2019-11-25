//
//  MapScreenViewTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerViewSample

class MapScreenViewTests: XCTestCase {
    let mapScreenView: MapScreenView = {
        let view = MapScreenView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        view.layoutIfNeeded()
        return view
    }()

    func testAddingSubview() {
        XCTAssertEqual(mapScreenView.subviews.count, 2)
    }

    func testARViewButtonFrame() {
        XCTAssertEqual(
            mapScreenView.arViewButton.frame,
            CGRect(x: 50, y: 400 - 50 - 8, width: 200, height: 50)
        )
    }

    func testMapViewFrame() {
        XCTAssertEqual(
            mapScreenView.mapView.frame,
            CGRect(x: 0, y: 0, width: 300, height: 400)
        )
    }
}
