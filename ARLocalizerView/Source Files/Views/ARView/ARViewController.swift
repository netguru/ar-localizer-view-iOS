//
//  ARViewController.swift
//  ARLocalizerView
//

import UIKit
import CoreLocation
import CoreMotion

final public class ARViewController: UIViewController {
    // MARK: Internal stored properties
    var viewUpdatingTimer: Timer?

    // MARK: Private stored properties
    private let locationManager = CLLocationManager()
    private let motionManager = CMMotionManager()
    private let viewRefreshInterval: TimeInterval
    private let poiLabelViewType: POILabelView.Type
    private var viewModel: ARViewModelProtocol

    // MARK: Private computed properties
    private var arView: ARView {
        view as! ARView
    }
    private var deviceGravityZ: Double {
        guard let deviceMotion = motionManager.deviceMotion else {
            return 0
        }
        return deviceMotion.gravity.z
    }
    private var deviceRotationInRadians: Double {
        guard let deviceMotion = motionManager.deviceMotion else {
            return 0
        }
        return atan2(deviceMotion.gravity.x, deviceMotion.gravity.y) - .pi
    }

    // MARK: Init
    public init(
        viewModel: ARViewModelProtocol,
        poiLabelViewType: POILabelView.Type = SimplePOILabelView.self,
        viewRefreshInterval: TimeInterval = 1.0 / 60.0
    ) {
        self.viewModel = viewModel
        self.poiLabelViewType = poiLabelViewType
        self.viewRefreshInterval = viewRefreshInterval
        super.init(nibName: nil, bundle: nil)
        arView.setupLabels(for: viewModel.pois)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        viewUpdatingTimer?.invalidate()
    }

    // MARK: Lifecycle methods
    override public func loadView() {
        view = ARView(frame: UIScreen.main.bounds, poiLabelViewType: poiLabelViewType)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        guard viewRefreshInterval > 0 else {
            return
        }

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()

        motionManager.deviceMotionUpdateInterval = viewRefreshInterval
        motionManager.startDeviceMotionUpdates(using: .xTrueNorthZVertical)

        setupViewUpdatingTimer()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        arView.startCameraPreview()
    }

    // MARK: Other methods
    private func setupViewUpdatingTimer() {
        viewUpdatingTimer = Timer.scheduledTimer(withTimeInterval: viewRefreshInterval, repeats: true) { [weak self] _ in
            self?.updateView()
        }
    }

    func updateView(
        withAuthorizationStatus authorizationStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
    ) {
        guard authorizationStatus == .authorizedWhenInUse else {
            return
        }
        viewModel.deviceGravityZ = deviceGravityZ
        viewModel.updatePOILabelsProperties()
        updateLabelViews()
    }

    private func updateLabelViews() {
       arView.labelsView.transform = CGAffineTransform(rotationAngle: CGFloat(deviceRotationInRadians))
       viewModel.poiLabelsProperties
           .sorted { $0.value.distance > $1.value.distance }
           .forEach { arView.updateLabel(forPOI: $0.key, withProperties: $0.value) }
       UIView.animate(withDuration: 0.2) {
           self.arView.labelsView.layoutIfNeeded()
       }
    }
}

// MARK: - Location Manager Delegate
extension ARViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        updateDeviceAzimuthInViewModel(
            withTrueHeading: newHeading.trueHeading,
            andHeadingAccuracy: newHeading.headingAccuracy
        )
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        viewModel.deviceLocation = location
    }

    func updateDeviceAzimuthInViewModel(
        withTrueHeading trueHeading: CLLocationDirection,
        andHeadingAccuracy headingAccuracy: CLLocationDirection
    ) {
        let deviceRotation = AngleConverter.convertToDegrees(radians: deviceRotationInRadians)
        var deviceAzimuth = trueHeading + deviceRotation
        if deviceAzimuth < 0 {
            deviceAzimuth += 360
        }
        viewModel.deviceAzimuth = deviceAzimuth
        viewModel.deviceAzimuthAccuracy = headingAccuracy
    }
}
