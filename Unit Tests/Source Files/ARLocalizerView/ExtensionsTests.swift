//
//  ExtensionsTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerView

class ExtensionsTests: XCTestCase {
    func testUIViewLayout() {
        let layoutableView = UIView().layoutable()
        XCTAssert(!layoutableView.translatesAutoresizingMaskIntoConstraints)
    }

    func testCGRectDiagonal() {
        let rect = CGRect(x: 0, y: 0, width: 30, height: 40)
        XCTAssert(rect.diagonalLength == 50)
    }

    func testSmallestAngle() {
        let angle1: Angle = 10
        let angle2: Angle = 100
        let angle3: Angle = 220

        XCTAssert(angle1.angularDistance(to: angle2) == -90)
        XCTAssert(angle1.angularDistance(to: angle3) == 150)
    }
}
