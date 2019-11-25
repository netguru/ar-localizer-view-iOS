//
//  ARScreenViewControllerTests.swift
//  ARLocalizerView
//

import XCTest
import CoreLocation
import ARLocalizerView
@testable import ARLocalizerViewSample

class ARScreenViewControllerTests: XCTestCase {
    var mockScreenViewControllerDelegate: MockScreenViewControllerDelegate!
    var arScreenViewController: ARScreenViewController!

    override func setUp() {
        super.setUp()
        mockScreenViewControllerDelegate = MockScreenViewControllerDelegate()
        arScreenViewController = ARScreenViewController(
            arViewController: ARViewController(viewModel: ARViewModel(poiProvider: nil)),
            delegate: mockScreenViewControllerDelegate
        )
    }

    func testAddingARViewController() {
        XCTAssertEqual(
            arScreenViewController.children.count,
            1,
            "arScreenViewController should have 1 child controller."
        )
        XCTAssertTrue(
            arScreenViewController.children.first is ARViewController,
            "arScreenViewController's child should be an ARViewController."
        )
    }

    func testTapOnMapButton() {
        mockScreenViewControllerDelegate.didTapOnButton = { animateTransition in
            XCTAssertTrue(animateTransition, "animateTransition should be set to true by default.")
        }
        arScreenViewController.didTapOnMapViewButton()
    }

    func testLoadingARScreenView() {
        let view = arScreenViewController.view
        XCTAssertTrue(view is ARScreenView, "View should be an ARScreenView.")
        XCTAssertEqual(
            (view as? ARScreenView)?.mapViewButton.allTargets.count,
            1,
            "mapViewButton should have exactly one target."
        )
    }
}
