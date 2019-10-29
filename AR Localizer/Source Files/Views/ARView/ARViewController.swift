//
//  ARViewController.swift
//  AR Localizer
//

import UIKit
import CoreLocation

final class ARViewController: UIViewController {

  private var viewModel: ARViewModelProtocol =
    ARViewModel(targetLocation: CLLocation(latitude: 52.4015279, longitude: 16.8918892))
  private let locationManager = CLLocationManager()
  private var arView: ARView { view as! ARView }

  override func loadView() {
    view = ARView(frame: UIScreen.main.bounds)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    locationManager.startUpdatingHeading()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    arView.startCameraPreview()
  }

  private func updateView() {
    arView.azimuthToNorthLabel.text = viewModel.azimuthToNorthLabelText
    arView.azimuthToTargetLocationLabel.text = viewModel.azimuthToTargetLocationLabelText
    arView.distanceLabel.text = viewModel.distanceLabelText
    arView.distanceLabel.isHidden = viewModel.distanceLabelIsHidden
    arView.distanceLabelXOffset = viewModel.distanceLabelXOffset
  }
}

// MARK: - Location Manager Delegate

extension ARViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    guard let heading = manager.heading else { return }
    viewModel.heading = heading
    updateView()
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let currentLocation = locations.first else { return }
    viewModel.currentLocation = currentLocation
    updateView()
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error while updating location " + error.localizedDescription)
  }
}
