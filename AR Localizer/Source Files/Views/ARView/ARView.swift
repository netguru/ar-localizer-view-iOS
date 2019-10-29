//
//  ARView.swift
//  AR Localizer
//

import UIKit

final class ARView: UIView {

  private enum Constants {
    static let DistanceLabelWidth: CGFloat = 100
    static let DistanceLabelHeight: CGFloat = 50
  }

  // MARK: Public properties

  let distanceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    if #available(iOS 13.0, *) {
      label.backgroundColor = .systemBackground
    } else {
      label.backgroundColor = .white
    }
    return label
  }()

  let azimuthToNorthLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let azimuthToTargetLocationLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  var distanceLabelXOffset: CGFloat = 0.0 {
    didSet {
      distanceLabelCenterXConstraint.constant = distanceLabelXOffset
    }
  }

  // MARK: Private properties

  private let cameraPreview: CameraPreview = {
    let cameraPreview = CameraPreview()
    cameraPreview.translatesAutoresizingMaskIntoConstraints = false
    return cameraPreview
  }()

  private lazy var distanceLabelCenterXConstraint: NSLayoutConstraint = {
    distanceLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
  }()

  // MARK: Init

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(cameraPreview)
    addSubview(distanceLabel)
    addSubview(azimuthToNorthLabel)
    addSubview(azimuthToTargetLocationLabel)

    activateConstaints()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Methods

  private func activateConstaints() {
    NSLayoutConstraint.activate(
      [
      cameraPreview.heightAnchor.constraint(equalTo: heightAnchor),
      cameraPreview.widthAnchor.constraint(equalTo: widthAnchor),
      cameraPreview.centerXAnchor.constraint(equalTo: centerXAnchor),
      cameraPreview.centerYAnchor.constraint(equalTo: centerYAnchor),

      azimuthToNorthLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      azimuthToNorthLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      azimuthToNorthLabel.bottomAnchor.constraint(equalTo: azimuthToTargetLocationLabel.topAnchor),

      azimuthToTargetLocationLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      azimuthToTargetLocationLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      azimuthToTargetLocationLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

      distanceLabel.widthAnchor.constraint(equalToConstant: Constants.DistanceLabelWidth),
      distanceLabel.heightAnchor.constraint(equalToConstant: Constants.DistanceLabelHeight),
      distanceLabelCenterXConstraint,
      distanceLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
      ]
    )
  }

  func startCameraPreview() {
    cameraPreview.start()
  }
}