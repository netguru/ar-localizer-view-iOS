//
//  CoordinatorTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerViewSample

class CoordinatorTests: XCTestCase {
    func testNavigation() {
        let coordinator = Coordinator(factory: Factory())
        let navigationController = coordinator.navigationController
        XCTAssertTrue(
            navigationController.visibleViewController is MapScreenViewController,
            "Initially the visible view controller should be a MapScreenViewController."
        )

        coordinator.didTapOnARViewButton(animateTransition: false)
        XCTAssertNotNil(
            navigationController.visibleViewController as? ARScreenViewController,
            "After clicking AR view button the visible view controller should be an ARScreenViewController."
        )

        coordinator.didTapOnMapViewButton(
            arScreenController: navigationController.visibleViewController as! ARScreenViewController,
            animateTransition: false
        )
        XCTAssertTrue(
            navigationController.visibleViewController is MapScreenViewController,
            "After clicking map view button the visible view controller should be a MapScreenViewController."
        )
    }
}
