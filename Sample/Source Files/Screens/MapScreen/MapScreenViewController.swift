//
//  MapScreenController.swift
//  ARLocalizerView
//

import UIKit
import MapKit
import ARLocalizerView

protocol MapScreenViewControllerDelegate: AnyObject {
    func didTapOnARViewButton()
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
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard let location = userLocation.location else { return }

        updateRegion(of: mapView)

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

    private func updateRegion(of mapView: MKMapView) {
        let region = MKCoordinateRegion(
            center: mapView.userLocation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }

    private func locationBounds(forUserLocation userLocation: MKUserLocation) -> LocationBounds {
        return (
            south: userLocation.coordinate.latitude - 0.01,
            west: userLocation.coordinate.longitude - 0.01,
            north: userLocation.coordinate.latitude + 0.01,
            east: userLocation.coordinate.longitude + 0.01
        )
    }
}
