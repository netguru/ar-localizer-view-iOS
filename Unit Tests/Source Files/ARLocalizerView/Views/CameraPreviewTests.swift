//
//  CameraPreviewTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerView

class CameraPreviewTests: XCTestCase {
    func testStart() {
        let cameraPreview = CameraPreview()
        XCTAssertEqual(
            cameraPreview.session.outputs.count,
            0,
            "Initially AVCaptureSession should have 0 outputs."
        )
        XCTAssertNil(
            cameraPreview.layer.sublayers?.count,
            "Initially cameraPreview's layer should have no sublayers."
        )

        cameraPreview.start()
        XCTAssertEqual(
            cameraPreview.session.outputs.count,
            1,
            "AVCaptureSession should have 1 output."
        )
        XCTAssertTrue(
            cameraPreview.layer.masksToBounds,
            "CameraPreview's layer shoud mask to bounds."
        )
        XCTAssertEqual(
            cameraPreview.layer.sublayers?.count,
            1,
            "CameraPreview's layer should have 1 sublayer."
        )
    }
}
