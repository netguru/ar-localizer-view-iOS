//
//  ExtensionsTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerView

class ExtensionsTests: XCTestCase {
    func testUIViewLayout() {
        XCTAssertFalse(
            UIView().layoutable().translatesAutoresizingMaskIntoConstraints,
            "Layoutable UIView should not translate autorisizing mask into constraints."
        )
    }

    func testCGRectDiagonal() {
        XCTAssertEqual(
            CGRect(x: 0, y: 0, width: 30, height: 40).diagonalLength,
            50,
            "The diagonal of 30x40 rectangle should be equal 50."
        )
    }

    func testSmallestAngle() {
        XCTAssertEqual(
            10.0.angularDistance(to: 100),
            -90,
            "Distance from 10 to should be equal -90."
        )
        XCTAssertEqual(
            10.0.angularDistance(to: 220),
            150,
            "Distance from 10 to 220 should be equal 150."
        )
    }
}
