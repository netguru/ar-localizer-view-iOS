//
//  SimplePOILabelViewTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerView

class SimplePOILabelViewTests: XCTestCase {
    let labelView = SimplePOILabelView()

    func testInit() {
        XCTAssertEqual(labelView.layer.cornerRadius, 10)
        XCTAssertEqual(labelView.layer.borderWidth, 1)
        XCTAssertTrue(labelView.layer.masksToBounds)
        labelView.layoutIfNeeded()
        XCTAssertEqual(labelView.distanceLabel.frame, labelView.bounds)
    }

    func testSettingDistance() {
        XCTAssertNotEqual(labelView.distanceLabel.text, "12345 m")
        labelView.distance = 12345
        XCTAssertEqual(labelView.distanceLabel.text, "12345 m")
    }

}
