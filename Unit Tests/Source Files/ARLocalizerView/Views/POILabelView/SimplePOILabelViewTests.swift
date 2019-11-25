//
//  SimplePOILabelViewTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerView

class SimplePOILabelViewTests: XCTestCase {
    var labelView: SimplePOILabelView!

    override func setUp() {
        super.setUp()
        labelView = SimplePOILabelView()
    }

    func testInit() {
        labelView.layoutIfNeeded()
        XCTAssertEqual(labelView.layer.cornerRadius, 10, "labelView's corner radius should equal 10.")
        XCTAssertEqual(labelView.layer.borderWidth, 1, "labelView's border width should equal 1.")
        XCTAssertTrue(labelView.layer.masksToBounds, "labelView should mask to bounds.")
        XCTAssertEqual(labelView.distanceLabel.frame, labelView.bounds, "distanceLabel fill labelView.")
    }

    func testSettingDistance() {
        XCTAssertNil(
            labelView.distanceLabel.text,
            "Initially distanceLabel's text should be empty."
        )
        labelView.distance = 12345
        XCTAssertEqual(
            labelView.distanceLabel.text,
            "12345 m",
            "distanceLabel's text should be '12345 m'."
        )
    }

}
