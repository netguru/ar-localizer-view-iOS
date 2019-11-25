//
//  ATMLabelViewTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerViewSample

class ATMLabelViewTests: XCTestCase {
    var labelView: ATMLabelView!

    override func setUp() {
        super.setUp()
        labelView = ATMLabelView()
    }

    func testInit() {
        labelView.layoutIfNeeded()
        XCTAssertEqual(labelView.layer.cornerRadius, 10, "labelView's corner radius should equal 10.")
        XCTAssertEqual(labelView.layer.borderWidth, 1, "labelView's border width should equal 1.")
        XCTAssertTrue(labelView.layer.masksToBounds, "labelView should mask to bounds.")
        XCTAssertEqual(
            labelView.distanceLabel.frame.minY,
            -5,
            "distanceLabel should be positioned with 5 point margin to labelView's bottom."
        )
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

    func testSettingName() {
        XCTAssertNil(labelView.nameLabel.text, "Initially nameLabel's text should be empty.")
        labelView.name = "netguru-HQ"
        XCTAssertEqual(labelView.nameLabel.text, "netguru-HQ", "Initially nameLabel's text should be 'netguru-HQ'.")
    }

    func testAppropriateAlpha() {
        labelView.distance = 250
        XCTAssertEqual(
            labelView.appropriateAlpha,
            1,
            "labelView's alpha should equal 1 when distance to POI is 250."
        )
        labelView.distance = 450
        XCTAssertEqual(
            labelView.appropriateAlpha,
            0.7,
            "labelView's alpha should equal 0.7 when distance to POI is 450."
        )
        labelView.distance = 750
        XCTAssertEqual(
            labelView.appropriateAlpha,
            0.4,
            "labelView's alpha should equal 0.4 when distance to POI is 750."
        )
        labelView.distance = 950
        XCTAssertEqual(
            labelView.appropriateAlpha,
            0.1,
            "labelView's alpha should equal 0.1 when distance to POI is 950."
        )
        labelView.distance = nil
        XCTAssertEqual(
            labelView.appropriateAlpha,
            0,
            "labelView's alpha should equal 0 when distance to POI is nil."
        )
    }
}
