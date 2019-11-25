//
//  ARScreenViewTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerViewSample

class ARScreenViewTests: XCTestCase {
    let arScreenView: ARScreenView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let arScreenView = ARScreenView(
            frame: CGRect(x: 0, y: 0, width: 300, height: 400),
            arView: view
        )
        arScreenView.layoutIfNeeded()
        return arScreenView
    }()

    func testAddingSubview() {
        XCTAssertEqual(arScreenView.subviews.count, 2)
    }

    func testARViewButtonFrame() {
        XCTAssertEqual(
            arScreenView.mapViewButton.frame,
            CGRect(x: 50, y: 400 - 50 - 8, width: 200, height: 50)
        )
    }

    func testMapViewFrame() {
        XCTAssertEqual(
            arScreenView.arView.frame,
            CGRect(x: 0, y: 0, width: 300, height: 400)
        )
    }
}
