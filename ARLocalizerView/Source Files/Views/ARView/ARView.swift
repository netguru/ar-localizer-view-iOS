//
//  ARView.swift
//  ARLocalizerView
//

import UIKit

final class ARView: UIView {
    private enum Constants {
        static let POILabelWidth: CGFloat = 100
        static let POILabelHeight: CGFloat = 50
    }

    private(set) var poiLabels: [POI: UILabel] = [:]
    private(set) var labelsView = UIView().layoutable()
    private let cameraPreview = CameraPreview().layoutable()

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCameraPreview()
        setupLabelsView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func setupLabels(for pois: [POI]) {
        poiLabels.removeAll()

        pois.forEach {
            let label = UILabel().layoutable()
            label.textAlignment = .center
            label.isHidden = true
            if #available(iOS 13.0, *) {
                label.backgroundColor = .systemBackground
            } else {
                label.backgroundColor = .white
            }
            labelsView.addSubview(label)
            activateConstraints(forDistanceLabel: label)
            poiLabels[$0] = label
        }
    }

    func updateLabel(forPOI poi: POI, withProperties properties: POILabelProperties) {
        guard let label = poiLabels[poi] else { return }
        label.isHidden = properties.isHidden
        label.text = properties.text

        let centerXConstraint = labelsView.constraints.first {
            $0.firstAnchor === label.centerXAnchor
        }
        centerXConstraint?.constant = properties.xOffset

        let centerYConstraint = labelsView.constraints.first {
            $0.firstAnchor === label.centerYAnchor
        }
        centerYConstraint?.constant = properties.yOffset
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
                labelsView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
                labelsView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
                labelsView.centerXAnchor.constraint(equalTo: centerXAnchor),
                labelsView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
    }

    private func activateConstraints(forDistanceLabel label: UILabel) {
        NSLayoutConstraint.activate(
            [
                label.widthAnchor.constraint(equalToConstant: Constants.POILabelWidth),
                label.heightAnchor.constraint(equalToConstant: Constants.POILabelHeight),
                label.centerXAnchor.constraint(equalTo: labelsView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: labelsView.centerYAnchor)
            ]
        )
    }
}
