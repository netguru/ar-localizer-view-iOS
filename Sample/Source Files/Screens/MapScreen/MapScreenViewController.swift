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
    private weak var delegate: MapScreenViewControllerDelegate?

    private var previousLocation: CLLocation?

    // MARK: - Init
    init(poiProvider: POIProvider, delegate: MapScreenViewControllerDelegate) {
        self.poiProvider = poiProvider
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        self.poiProvider.didUpdate = didUpdate
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = MapScreenView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        guard let view = view as? MapScreenView else {
            return
        }
        view.arViewButton.addTarget(self, action: #selector(didTapOnARViewButton), for: .touchUpInside)
        view.mapView.delegate = self
    }

    @objc func didTapOnARViewButton() {
        delegate?.didTapOnARViewButton()
    }

    func didUpdate() {
        let updateAnnotations = {
            guard
                let view = self.view as? MapScreenView
            else {
                return
            }
            view.mapView.removeAnnotations(view.mapView.annotations)
            view.mapView.addAnnotations(self.poiProvider.pois)
        }

        guard !Thread.isMainThread else {
            updateAnnotations()
            return
        }

        DispatchQueue.main.async(execute: updateAnnotations)
    }
}

// MARK: - Map View Delegate
extension MapScreenViewController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapView.userTrackingMode = .followWithHeading
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard let location = userLocation.location else {
            return
        }
        guard let previousLocation = previousLocation else {
            updatePOIProviderLocationBounds(with: location)
            return
        }

        guard location.distance(from: previousLocation) > 200 else {
            return
        }

        updatePOIProviderLocationBounds(with: location)
    }

    func updatePOIProviderLocationBounds(with location: CLLocation) {
        poiProvider.locationBounds = locationBounds(forCoordinate: location.coordinate)
        previousLocation = location
    }

    private func locationBounds(forCoordinate coordinate: CLLocationCoordinate2D) -> LocationBounds {
        return (
            south: coordinate.latitude - Constants.distanceFromLocationToBound,
            west: coordinate.longitude - Constants.distanceFromLocationToBound,
            north: coordinate.latitude + Constants.distanceFromLocationToBound,
            east: coordinate.longitude + Constants.distanceFromLocationToBound
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
