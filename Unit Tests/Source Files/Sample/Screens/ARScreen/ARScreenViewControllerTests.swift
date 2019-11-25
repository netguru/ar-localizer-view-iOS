//
//  ARScreenViewControllerTests.swift
//  ARLocalizerView
//

import XCTest
import CoreLocation
import ARLocalizerView
@testable import ARLocalizerViewSample

class ARScreenViewControllerTests: XCTestCase {
    let mockPOIProvider = MockPOIProvider()
    let mockScreenViewControllerDelegate = MockScreenViewControllerDelegate()
    lazy var arScreenViewController = ARScreenViewController(
        arViewController: ARViewController(
            viewModel: ARViewModel(poiProvider: mockPOIProvider)
        ),
        delegate: mockScreenViewControllerDelegate
    )

    func testAddingARViewController() {
        XCTAssertEqual(arScreenViewController.children.count, 1)
        XCTAssertTrue(arScreenViewController.children.first is ARViewController)
    }

    func testTapOnMapButton() {
        mockScreenViewControllerDelegate.didTapOnButton = { animateTransition in
            XCTAssertTrue(animateTransition)
        }
        arScreenViewController.didTapOnMapViewButton()
    }

    func testLoadingARScreenView() {
        let view = arScreenViewController.view
        XCTAssertTrue(view is ARScreenView)
        XCTAssertEqual((view as? ARScreenView)?.mapViewButton.allTargets.count, 1)
    }
}
