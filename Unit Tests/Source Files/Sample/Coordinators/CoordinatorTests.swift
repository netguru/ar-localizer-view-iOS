//
//  CoordinatorTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerViewSample

class CoordinatorTests: XCTestCase {
    func testNavigation() {
        let coordinator = Coordinator(factory: Factory())
        XCTAssertTrue(coordinator.navigationController.visibleViewController is MapScreenViewController)
        coordinator.didTapOnARViewButton(animateTransition: false)
        let arScreenViewController = coordinator.navigationController.visibleViewController as? ARScreenViewController
        XCTAssertNotNil(arScreenViewController)
        coordinator.didTapOnMapViewButton(arScreenController: arScreenViewController!, animateTransition: false)
        XCTAssertTrue(coordinator.navigationController.visibleViewController is MapScreenViewController)
    }
}
