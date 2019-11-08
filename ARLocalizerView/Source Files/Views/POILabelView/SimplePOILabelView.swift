//
//  SimplePOILabelView.swift
//  ARLocalizerView
//

import UIKit

public final class SimplePOILabelView: UIView, POILabelView {
    private enum Constants {
        static let width: CGFloat = 100
        static let height: CGFloat = 50
    }

    public var distance: Double = 0 {
        didSet {
            distanceLabel.text = distanceTextGenerator(distance)
        }
    }
    public var distanceTextGenerator: (Double) -> String = { distance in
        return "\(Int(distance)) m"
    }

    private let distanceLabel: UILabel = {
        let label = UILabel().layoutable()
        label.textAlignment = .center
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
        } else {
            label.backgroundColor = .white
        }
        return label
    }()

    override init(frame: CGRect = CGRect(x: 0, y: 0, width: Constants.width, height: Constants.height)) {
        super.init(frame: frame)
        if #available(iOS 13.0, *) {
            layer.backgroundColor = UIColor.systemBackground.cgColor
            layer.borderColor = UIColor.label.withAlphaComponent(0.5).cgColor
        } else {
            layer.backgroundColor = UIColor.white.cgColor
            layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        }
        layer.borderWidth = 1
        layer.cornerRadius = 10
        clipsToBounds = true

        setupDistanceLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDistanceLabel() {
        addSubview(distanceLabel)
        activateConstaintsForDistanceLabel()
    }

    private func activateConstaintsForDistanceLabel() {
        NSLayoutConstraint.activate(
            [
                distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                distanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                distanceLabel.topAnchor.constraint(equalTo: topAnchor),
                distanceLabel.widthAnchor.constraint(equalToConstant: Constants.width),
                distanceLabel.heightAnchor.constraint(equalToConstant: Constants.height)
            ]
        )
    }
}