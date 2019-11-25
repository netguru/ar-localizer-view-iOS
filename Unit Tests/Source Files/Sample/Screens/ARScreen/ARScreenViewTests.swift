//
//  ARScreenViewTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerViewSample

class ARScreenViewTests: XCTestCase {
    var arScreenView: ARScreenView!

    override func setUp() {
        super.setUp()
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        arScreenView = ARScreenView(
            frame: CGRect(x: 0, y: 0, width: 300, height: 400),
            arView: view
        )
        arScreenView.layoutIfNeeded()
    }

    func testAddingSubview() {
        XCTAssertEqual(arScreenView.subviews.count, 2, "arScreenView should have two subviews.")
    }

    func testARViewButtonFrame() {
        XCTAssertEqual(
            arScreenView.mapViewButton.frame,
            CGRect(x: 50, y: 400 - 50 - 8, width: 200, height: 50),
            "mapViewButton should be positioned on the bottom-center of the arScreenView."
        )
    }

    func testMapViewFrame() {
        XCTAssertEqual(
            arScreenView.arView.frame,
            CGRect(x: 0, y: 0, width: 300, height: 400),
            "arView should fill the arScreenView."
        )
    }
}
