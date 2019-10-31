//
//  ARView.swift
//  AR Localizer
//

import UIKit

final class ARView: UIView {

  private enum Constants {
    static let POILabelWidth: CGFloat = 100
    static let POILabelHeight: CGFloat = 50
  }

  // MARK: Public properties
  var poiLabels: [POI: UILabel] = [:]

  // MARK: Private properties
  private let cameraPreview: CameraPreview = {
    let cameraPreview = CameraPreview()
    cameraPreview.translatesAutoresizingMaskIntoConstraints = false
    return cameraPreview
  }()

  // MARK: Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCameraPreview()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Public Methods
  func setupLabels(for pois: [POI]) {
    poiLabels.removeAll()

    pois.forEach {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textAlignment = .center
      label.isHidden = true
      if #available(iOS 13.0, *) {
        label.backgroundColor = .systemBackground
      } else {
        label.backgroundColor = .white
      }
      addSubview(label)
      activateConstraints(forDistanceLabel: label)
      poiLabels[$0] = label
    }
  }

  func updateLabel(forPOI poi: POI, withProperties properties: POILabelProperties) {
    guard let label = poiLabels[poi] else { return }
    label.isHidden = properties.isHidden
    label.text = properties.text
    let centerXConstraint = constraints.first { $0.firstAnchor == label.centerXAnchor }
    centerXConstraint?.constant = properties.xOffset
    let centerYConstraint = constraints.first { $0.firstAnchor == label.centerYAnchor }
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

  private func activateConstraints(forDistanceLabel label: UILabel) {
    NSLayoutConstraint.activate(
      [
      label.widthAnchor.constraint(equalToConstant: 100),
      label.heightAnchor.constraint(equalToConstant: 50),
      label.centerXAnchor.constraint(equalTo: centerXAnchor),
      label.centerYAnchor.constraint(equalTo: centerYAnchor)
      ]
    )
  }
}
