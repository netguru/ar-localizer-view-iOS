//
//  ARViewTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerView

class ARViewTests: XCTestCase {
    let poi = POI(name: "netguru-HQ", latitude: 52.4015279, longitude: 16.8918892)

    let arView = ARView(
        frame: CGRect(x: 0, y: 0, width: 30, height: 40),
        poiLabelViewType: SimplePOILabelView.self
    )

    func testSetupLabelsView() {
        arView.layoutIfNeeded()
        XCTAssertEqual(arView.labelsView.frame.minX, -10)
        XCTAssertEqual(arView.labelsView.frame.minY, -5)
        XCTAssertEqual(arView.labelsView.frame.width, 50)
        XCTAssertEqual(arView.labelsView.frame.height, 50)
    }

    func testSetupLabels() {
        XCTAssertNil(arView.poiLabelViews[poi])
        arView.setupLabels(for: [poi])
        arView.labelsView.layoutIfNeeded()
        XCTAssertNotNil(arView.poiLabelViews[poi])
        XCTAssertEqual(arView.poiLabelViews[poi]?.frame.minX, -25)
        XCTAssertEqual(arView.poiLabelViews[poi]?.frame.minY, 0)
    }

    func testUpdateLabel() {
        let properties = POILabelProperties(
            xOffset: 0,
            yOffset: 0,
            name: "netguru-HQ",
            distance: 500,
            isHidden: false
        )
        XCTAssertNil(arView.poiLabelViews.first?.value)
        arView.setupLabels(for: [poi])
        XCTAssertNotEqual(arView.poiLabelViews[poi]?.name, "netguru-HQ")
        XCTAssertNotEqual(arView.poiLabelViews[poi]?.distance, 500)
        arView.updateLabel(forPOI: poi, withProperties: properties)
        XCTAssertEqual(arView.poiLabelViews[poi]?.name, "netguru-HQ")
        XCTAssertEqual(arView.poiLabelViews[poi]?.distance, 500)
    }

}
