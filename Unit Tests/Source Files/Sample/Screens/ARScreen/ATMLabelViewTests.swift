//
//  ATMLabelViewTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerViewSample

class ATMLabelViewTests: XCTestCase {
    let labelView = ATMLabelView()

    func testInit() {
        XCTAssertEqual(labelView.layer.cornerRadius, 10)
        XCTAssertEqual(labelView.layer.borderWidth, 1)
        XCTAssertTrue(labelView.layer.masksToBounds)
        labelView.layoutIfNeeded()
        XCTAssertEqual(labelView.distanceLabel.frame.minY, -5)
    }

    func testSettingDistance() {
        XCTAssertNotEqual(labelView.distanceLabel.text, "12345 m")
        labelView.distance = 12345
        XCTAssertEqual(labelView.distanceLabel.text, "12345 m")
    }

    func testSettingName() {
        XCTAssertNotEqual(labelView.nameLabel.text, "netguru-HQ")
        labelView.name = "netguru-HQ"
        XCTAssertEqual(labelView.nameLabel.text, "netguru-HQ")
    }

    func testAppropriateAlpha() {
        labelView.distance = 250
        XCTAssertEqual(labelView.appropriateAlpha, 1)
        labelView.distance = 450
        XCTAssertEqual(labelView.appropriateAlpha, 0.7)
        labelView.distance = 750
        XCTAssertEqual(labelView.appropriateAlpha, 0.4)
        labelView.distance = 950
        XCTAssertEqual(labelView.appropriateAlpha, 0.1)
    }

}
