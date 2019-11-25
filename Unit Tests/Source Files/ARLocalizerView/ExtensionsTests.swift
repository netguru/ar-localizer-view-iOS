//
//  ExtensionsTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerView

class ExtensionsTests: XCTestCase {
    func testUIViewLayout() {
        let layoutableView = UIView().layoutable()
        XCTAssertFalse(layoutableView.translatesAutoresizingMaskIntoConstraints)
    }

    func testCGRectDiagonal() {
        let rect = CGRect(x: 0, y: 0, width: 30, height: 40)
        XCTAssertEqual(rect.diagonalLength, 50)
    }

    func testSmallestAngle() {
        let angle1: Angle = 10
        let angle2: Angle = 100
        let angle3: Angle = 220

        XCTAssertEqual(angle1.angularDistance(to: angle2), -90)
        XCTAssertEqual(angle1.angularDistance(to: angle3), 150)
    }
}
