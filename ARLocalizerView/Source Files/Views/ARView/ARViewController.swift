//
//  ARViewController.swift
//  ARLocalizerView
//

import UIKit
import CoreLocation

final public class ARViewController: UIViewController {
    // MARK: Private properties
    private let locationManager = CLLocationManager()
    private var viewModel: ARViewModelProtocol
    private var arView: ARView {
        view as! ARView
    }

    // MARK: Init
    public init(viewModel: ARViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        arView.setupLabels(for: viewModel.pois)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods
    private func updateView() {
        viewModel.poiLabelsProperties.forEach {
            arView.updateLabel(forPOI: $0.key, withProperties: $0.value)
        }
        UIView.animate(withDuration: 0.2) {
            self.arView.layoutIfNeeded()
        }
    }
}

// MARK: - View Controller
extension ARViewController {
    override public func loadView() {
        view = ARView(frame: UIScreen.main.bounds)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        arView.startCameraPreview()
    }
}

// MARK: - Location Manager Delegate
extension ARViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard let heading = manager.heading else { return }
        viewModel.setHeading(heading)
        updateView()
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        viewModel.setLocation(location)
        updateView()
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
}
