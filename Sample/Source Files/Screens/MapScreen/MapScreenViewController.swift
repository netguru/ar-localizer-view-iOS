//
//  MapScreenController.swift
//  ARLocalizerView
//

import UIKit
import MapKit
import ARLocalizerView

protocol MapScreenViewControllerDelegate: AnyObject {
    func didTapOnARViewButton(animateTransition: Bool)
}

extension MapScreenViewControllerDelegate {
    func didTapOnARViewButton() {
        didTapOnARViewButton(animateTransition: true)
    }
}

final class MapScreenViewController: UIViewController {
    private var poiProvider: POIProvider
    private var previousUserLocation: MKUserLocation?
    private weak var delegate: MapScreenViewControllerDelegate?

    // MARK: - Init
    init(poiProvider: POIProvider, delegate: MapScreenViewControllerDelegate) {
        self.poiProvider = poiProvider
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        self.poiProvider.didUpdate = { [weak self] in
            DispatchQueue.main.async {
                guard let view = self?.view as? MapScreenView else {
                    return
                }
                view.mapView.removeAnnotations(view.mapView.annotations)
                view.mapView.addAnnotations(poiProvider.pois)
            }
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = MapScreenView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        guard let view = view as? MapScreenView else { return }
        view.arViewButton.addTarget(self, action: #selector(didTapOnARViewButton), for: .touchUpInside)
        view.mapView.delegate = self
    }

    @objc func didTapOnARViewButton() {
        delegate?.didTapOnARViewButton()
    }
}

// MARK: - Map View Delegate
extension MapScreenViewController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapView.userTrackingMode = .followWithHeading
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard let location = userLocation.location else { return }
        guard let previousLocation = previousUserLocation?.location else {
            updatePOIProviderLocationBounds(with: userLocation)
            return
        }

        guard location.distance(from: previousLocation) > 200 else { return }

        updatePOIProviderLocationBounds(with: userLocation)
    }

    private func updatePOIProviderLocationBounds(with userLocation: MKUserLocation) {
        poiProvider.locationBounds = locationBounds(forUserLocation: userLocation)
        previousUserLocation = userLocation
    }

    private func locationBounds(forUserLocation userLocation: MKUserLocation) -> LocationBounds {
        return (
            south: userLocation.coordinate.latitude - Constants.distanceFromLocationToBound,
            west: userLocation.coordinate.longitude - Constants.distanceFromLocationToBound,
            north: userLocation.coordinate.latitude + Constants.distanceFromLocationToBound,
            east: userLocation.coordinate.longitude + Constants.distanceFromLocationToBound
        )
    }
}

// MARK: - Constants
extension MapScreenViewController {
    private enum Constants {
        /// Distance between every location bound and the location used to specify them. Measured in angles.
        static let distanceFromLocationToBound: Angle = 0.015
    }
}
