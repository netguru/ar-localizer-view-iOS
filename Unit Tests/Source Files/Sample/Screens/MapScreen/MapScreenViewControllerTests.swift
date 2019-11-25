//
//  MapScreenViewControllerTests.swift
//  ARLocalizerView
//

import XCTest
import CoreLocation
import ARLocalizerView
@testable import ARLocalizerViewSample

class MapScreenViewControllerTests: XCTestCase {
    let examplePOI = POI(name: "netguru-HQ", latitude: 52.4015279, longitude: 16.8918892)

    var mockPOIProvider: MockPOIProvider!
    var mockScreenViewControllerDelegate: MockScreenViewControllerDelegate!
    var mapScreenViewController: MapScreenViewController!

    override func setUp() {
        super.setUp()
        mockPOIProvider = MockPOIProvider()
        mockScreenViewControllerDelegate = MockScreenViewControllerDelegate()
        mapScreenViewController = MapScreenViewController(
            poiProvider: mockPOIProvider,
            delegate: mockScreenViewControllerDelegate
        )
    }

    func testTapOnARButton() {
        mockScreenViewControllerDelegate.didTapOnButton = { animateTransition in
            XCTAssertTrue(animateTransition)
        }
        mapScreenViewController.didTapOnARViewButton()
    }

    func testUpdatePOIs() {
        XCTAssertEqual(
            (mapScreenViewController.view as? MapScreenView)?.mapView.annotations.count,
            0,
            "Initialy there should be 0 annotations on the mapView."
        )
        mockPOIProvider.pois = [examplePOI]
        mapScreenViewController.didUpdate()
        XCTAssertEqual(
            (self.mapScreenViewController.view as? MapScreenView)?.mapView.annotations.count,
            1,
            "There should be exactly 1 annotation on the mapView."
        )
    }

    func testUpdatingLocationBounds() {
        XCTAssertNil(mockPOIProvider.locationBounds, "Initially locationBounds should be nil.")
        mockPOIProvider.didSetLocationBounds = {
            XCTAssertEqual(
                self.mockPOIProvider.locationBounds?.south
                    .distance(to: 52.3865279)
                    .isLessThanOrEqualTo(0.00000001),
                true,
                "South location bound should be equal 52.3865279."
            )
            XCTAssertEqual(
                self.mockPOIProvider.locationBounds?.west
                    .distance(to: 16.8768892)
                    .isLessThanOrEqualTo(0.00000001),
                true,
                "West location bound should be equal 16.8768892."
            )
            XCTAssertEqual(
                self.mockPOIProvider.locationBounds?.north
                    .distance(to: 52.4165279)
                    .isLessThanOrEqualTo(0.00000001),
                true,
                "North location bound should be equal 52.4165279."
            )
            XCTAssertEqual(
                self.mockPOIProvider.locationBounds?.east
                    .distance(to: 16.9068892)
                    .isLessThanOrEqualTo(0.00000001),
                true,
                "East location bound should be equal 16.9068892."
            )
        }

        mapScreenViewController.updatePOIProviderLocationBounds(
            with: CLLocation(latitude: 52.4015279, longitude: 16.8918892)
        )
    }
}
