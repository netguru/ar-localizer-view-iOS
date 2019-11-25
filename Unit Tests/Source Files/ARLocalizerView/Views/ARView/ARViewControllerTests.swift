//
//  ARViewControllerTests.swift
//  ARLocalizerView
//

import XCTest
import CoreLocation
@testable import ARLocalizerView

class ARViewControllerTests: XCTestCase {
    let viewModel = ARViewModel(poiProvider: nil)
    lazy var arViewController = ARViewController(
        viewModel: viewModel,
        viewRefreshInterval: 0
    )

    func testARViewInit() {
        XCTAssertNotNil(arViewController.view as? ARView)
    }

    func testUpdateViewTimerInitAndDeinit() {
        var controller: ARViewController? = ARViewController(viewModel: ARViewModel(poiProvider: nil))
        let timer = controller?.updateViewTimer

        XCTAssertNotNil(timer)
        XCTAssertEqual(timer?.isValid, true)

        controller = nil

        DispatchQueue.main.async {
            XCTAssertEqual(timer?.isValid, false)
        }
    }

    func testDidUpdateHeading() {
        arViewController.updateDeviceAzimuthInViewModel(withTrueHeading: 45, andHeadingAccuracy: 2)
        XCTAssertEqual(viewModel.deviceAzimuth, 45)
        XCTAssertEqual(viewModel.deviceAzimuthAccuracy, 2)
    }

    func testDidUpdateLocation() {
        arViewController.locationManager(
            CLLocationManager(), didUpdateLocations: [CLLocation(latitude: 50, longitude: 16)]
        )
        XCTAssertEqual(viewModel.deviceLocation?.coordinate.latitude, 50)
        XCTAssertEqual(viewModel.deviceLocation?.coordinate.longitude, 16)
    }

    func testUpdateView() {
        viewModel.deviceGravityZ = 0.55
        XCTAssertEqual(viewModel.deviceGravityZ, 0.55)
        arViewController.updateView(withAuthorizationStatus: .restricted)
        XCTAssertEqual(viewModel.deviceGravityZ, 0.55)
        arViewController.updateView(withAuthorizationStatus: .authorizedWhenInUse)
        XCTAssertEqual(viewModel.deviceGravityZ, 0)
    }
}
