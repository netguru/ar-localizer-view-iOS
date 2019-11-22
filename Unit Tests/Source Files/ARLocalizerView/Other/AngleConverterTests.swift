//
//  AngleConverterTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerView

class AngleConverterTests: XCTestCase {
    func testConvertToDegress() {
        XCTAssert(AngleConverter.convertToDegrees(radians: .pi) == 180)
    }
}
