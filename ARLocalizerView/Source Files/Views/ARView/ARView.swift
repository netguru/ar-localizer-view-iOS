//
//  ARView.swift
//  ARLocalizerView
//

import UIKit

final class ARView: UIView {
    private(set) var poiLabelViews: [POI: POILabelView] = [:]
    private(set) var labelsView = UIView().layoutable()
    private let cameraPreview = CameraPreview().layoutable()
    private let poiLabelViewType: POILabelView.Type

    // MARK: Init
    init(frame: CGRect, poiLabelViewType: POILabelView.Type) {
        self.poiLabelViewType = poiLabelViewType
        super.init(frame: frame)
        clipsToBounds = true
        setupCameraPreview()
        setupLabelsView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func setupLabels(for pois: [POI]) {
        poiLabelViews.removeAll()

        pois.forEach {
            let poiLabelView = poiLabelViewType.init().layoutable()
            labelsView.addSubview(poiLabelView)
            activateConstraints(forPOILabelView: poiLabelView)
            poiLabelViews[$0] = poiLabelView
        }
    }

    func updateLabel(forPOI poi: POI, withProperties properties: POILabelProperties) {
        guard let poiLabelView = poiLabelViews[poi] else { return }
        poiLabelView.isHidden = properties.isHidden
        poiLabelView.name = properties.name
        poiLabelView.distance = properties.distance

        let centerXConstraint = labelsView.constraints.first {
            $0.firstAnchor === poiLabelView.centerXAnchor
        }
        centerXConstraint?.constant = properties.xOffset

        let centerYConstraint = labelsView.constraints.first {
            $0.firstAnchor === poiLabelView.centerYAnchor
        }
        centerYConstraint?.constant = properties.yOffset

        labelsView.bringSubviewToFront(poiLabelView)
    }

    func startCameraPreview() {
        cameraPreview.start()
    }

    // MARK: Private Methods
    private func setupCameraPreview() {
        addSubview(cameraPreview)
        activateConstaintsForCameraPreview()
    }

    private func setupLabelsView() {
        addSubview(labelsView)
        activateConstaintsForLabelsView()
    }

    private func activateConstaintsForCameraPreview() {
        NSLayoutConstraint.activate(
            [
                cameraPreview.heightAnchor.constraint(equalTo: heightAnchor),
                cameraPreview.widthAnchor.constraint(equalTo: widthAnchor),
                cameraPreview.centerXAnchor.constraint(equalTo: centerXAnchor),
                cameraPreview.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
    }

    private func activateConstaintsForLabelsView() {
        NSLayoutConstraint.activate(
            [
                labelsView.heightAnchor.constraint(equalToConstant: UIScreen.main.diagonal),
                labelsView.widthAnchor.constraint(equalToConstant: UIScreen.main.diagonal),
                labelsView.centerXAnchor.constraint(equalTo: centerXAnchor),
                labelsView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
    }

    private func activateConstraints(forPOILabelView poiLabelView: POILabelView) {
        NSLayoutConstraint.activate(
            [
                poiLabelView.centerXAnchor.constraint(equalTo: labelsView.centerXAnchor),
                poiLabelView.centerYAnchor.constraint(equalTo: labelsView.centerYAnchor)
            ]
        )
    }
}
