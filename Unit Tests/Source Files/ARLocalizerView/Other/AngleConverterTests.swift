//
//  AngleConverterTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerView

class AngleConverterTests: XCTestCase {
    func testConvertToDegress() {
        XCTAssertEqual(
            AngleConverter.convertToDegrees(radians: .pi),
            180,
            "Pi converted to angles should equal 180."
        )
    }
}
