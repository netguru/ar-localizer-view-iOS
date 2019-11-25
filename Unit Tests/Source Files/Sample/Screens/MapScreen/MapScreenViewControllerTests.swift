//
//  MapScreenViewControllerTests.swift
//  ARLocalizerView
//

import XCTest
import CoreLocation
import ARLocalizerView
@testable import ARLocalizerViewSample

class MapScreenViewControllerTests: XCTestCase {
    let poi = POI(name: "netguru-HQ", latitude: 52.4015279, longitude: 16.8918892)
    let mockPOIProvider = MockPOIProvider()
    let mockScreenViewControllerDelegate = MockScreenViewControllerDelegate()
    lazy var mapScreenViewController = MapScreenViewController(
        poiProvider: mockPOIProvider,
        delegate: mockScreenViewControllerDelegate
    )

    func testTapOnARButton() {
        mockScreenViewControllerDelegate.didTapOnButton = { animateTransition in
            XCTAssertTrue(animateTransition)
        }
        mapScreenViewController.didTapOnARViewButton()
    }

    func testUpdatePOIs() {
        XCTAssertEqual(
            (mapScreenViewController.view as? MapScreenView)?.mapView.annotations.count,
            0
        )
        mockPOIProvider.pois = [poi]
        mockPOIProvider.didUpdate?()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(
                (self.mapScreenViewController.view as? MapScreenView)?.mapView.annotations.count,
                1
            )
        }
    }

    func testUpdatingLocationBounds() {
        mockPOIProvider.didSetLocationBounds = {
            XCTAssertEqual(
                self.mockPOIProvider.locationBounds?.south
                    .distance(to: 52.3865279)
                    .isLessThanOrEqualTo(0.00000001),
                false
            )
            XCTAssertEqual(
                self.mockPOIProvider.locationBounds?.west
                    .distance(to: 16.8768892)
                    .isLessThanOrEqualTo(0.00000001),
                false
            )
            XCTAssertEqual(
                self.mockPOIProvider.locationBounds?.north
                    .distance(to: 52.4165279)
                    .isLessThanOrEqualTo(0.00000001),
                false
            )
            XCTAssertEqual(
                self.mockPOIProvider.locationBounds?.east
                    .distance(to: 16.9068892)
                    .isLessThanOrEqualTo(0.00000001),
                false
            )
        }

        mockPOIProvider.didSetLocationBounds = {
            XCTAssertEqual(
                self.mockPOIProvider.locationBounds?.south
                    .distance(to: 52.3865279)
                    .isLessThanOrEqualTo(0.00000001),
                true
            )
            XCTAssertEqual(
                self.mockPOIProvider.locationBounds?.west
                    .distance(to: 16.8768892)
                    .isLessThanOrEqualTo(0.00000001),
                true
            )
            XCTAssertEqual(
                self.mockPOIProvider.locationBounds?.north
                    .distance(to: 52.4165279)
                    .isLessThanOrEqualTo(0.00000001),
                true
            )
            XCTAssertEqual(
                self.mockPOIProvider.locationBounds?.east
                    .distance(to: 16.9068892)
                    .isLessThanOrEqualTo(0.00000001),
                true
            )
        }

        mapScreenViewController.updatePOIProviderLocationBounds(
            with: CLLocation(latitude: 52.4015279, longitude: 16.8918892)
        )
    }
}
