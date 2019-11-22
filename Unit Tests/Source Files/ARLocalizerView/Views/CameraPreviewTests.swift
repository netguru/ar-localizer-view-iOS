//
//  CameraPreviewTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerView

class CameraPreviewTests: XCTestCase {
    func testStart() {
        let cameraPreview = CameraPreview()
        XCTAssertNotEqual(cameraPreview.session.outputs.count, 1)
        XCTAssertNotEqual(cameraPreview.layer.sublayers?.count, 1)
        cameraPreview.start()
        XCTAssertEqual(cameraPreview.session.outputs.count, 1)
        XCTAssertTrue(cameraPreview.layer.masksToBounds)
        XCTAssertEqual(cameraPreview.layer.sublayers?.count, 1)
    }
}
