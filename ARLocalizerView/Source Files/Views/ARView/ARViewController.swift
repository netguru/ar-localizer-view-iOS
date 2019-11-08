//
//  ARViewController.swift
//  ARLocalizerView
//

import UIKit
import CoreLocation
import CoreMotion

final public class ARViewController: UIViewController {
    // MARK: Private stored properties
    private let locationManager = CLLocationManager()
    private let motionManager = CMMotionManager()
    private let poiLabelViewType: POILabelView.Type
    private var viewModel: ARViewModelProtocol
    private var timer: Timer?

    // MARK: Private computed properties
    private var arView: ARView {
        view as! ARView
    }
    private var deviceGravityZ: Double {
        guard let deviceMotion = motionManager.deviceMotion else { return 0 }
        return deviceMotion.gravity.z
    }
    private var deviceRotationInRadians: Double {
        guard let deviceMotion = motionManager.deviceMotion else { return 0 }
        return atan2(deviceMotion.gravity.x, deviceMotion.gravity.y) - .pi
    }

    // MARK: Init
    public init(viewModel: ARViewModelProtocol, poiLabelViewType: POILabelView.Type = SimplePOILabelView.self) {
        self.viewModel = viewModel
        self.poiLabelViewType = poiLabelViewType
        super.init(nibName: nil, bundle: nil)
        arView.setupLabels(for: viewModel.pois)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        timer?.invalidate()
    }

    // MARK: Lifecycle methods
    override public func loadView() {
        view = ARView(frame: UIScreen.main.bounds, poiLabelViewType: poiLabelViewType)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()

        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(using: .xTrueNorthZVertical)

        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { [weak self] _ in
            guard
                let self = self,
                CLLocationManager.authorizationStatus() == .authorizedWhenInUse
            else {
                return
            }
            self.viewModel.deviceGravityZ = self.deviceGravityZ
            self.viewModel.updatePOILabelsProperties()
            self.updateView()
        }
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        arView.startCameraPreview()
    }

    // MARK: Other methods
    private func updateView() {
        arView.labelsView.transform = CGAffineTransform(rotationAngle: CGFloat(deviceRotationInRadians))
        viewModel.poiLabelsProperties.forEach {
            arView.updateLabel(forPOI: $0.key, withProperties: $0.value)
        }
        UIView.animate(withDuration: 0.1) {
            self.arView.labelsView.layoutIfNeeded()
        }
    }
}

// MARK: - Location Manager Delegate
extension ARViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard let heading = manager.heading else { return }
        let deviceRotation = AngleConverter.convertToDegrees(radians: deviceRotationInRadians)
        var newDeviceAzimuth = heading.trueHeading + deviceRotation
        if newDeviceAzimuth < 0 {
            newDeviceAzimuth += 360
        }
        viewModel.deviceAzimuth = newDeviceAzimuth
        viewModel.deviceAzimuthAccuracy = heading.headingAccuracy
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        viewModel.deviceLocation = location
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
}
