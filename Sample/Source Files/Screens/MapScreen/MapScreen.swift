//
//  MapScreenController.swift
//  ARLocalizerView
//

import UIKit
import MapKit

final class MapScreen: UIView {
    let arViewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open AR view", for: .normal)
        if #available(iOS 13.0, *) {
            button.layer.borderColor = UIColor.label.cgColor
        } else {
            button.layer.borderColor = UIColor.black.cgColor
        }
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.isScrollEnabled = false
        mapView.isRotateEnabled = false
        mapView.isZoomEnabled = false
        return mapView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMapView()
        setupMapViewButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupMapView() {
        addSubview(mapView)
        activateMapViewConstraints()
    }

    private func setupMapViewButton() {
        addSubview(arViewButton)
        activateMapViewButtonConstraints()
    }

    private func activateMapViewConstraints() {
        NSLayoutConstraint.activate(
            [
                mapView.topAnchor.constraint(equalTo: topAnchor),
                mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
                mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
                mapView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        )
    }

    private func activateMapViewButtonConstraints() {
        NSLayoutConstraint.activate(
            [
                arViewButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                arViewButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                arViewButton.widthAnchor.constraint(equalToConstant: 200),
                arViewButton.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
    }
}
