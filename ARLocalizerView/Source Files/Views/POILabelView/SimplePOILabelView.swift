//
//  SimplePOILabelView.swift
//  ARLocalizerView
//

import UIKit

public final class SimplePOILabelView: UIView, POILabelView {
    public var name: String? = ""

    public var distance: Double = 0 {
        didSet {
            distanceLabel.text = distanceTextGenerator(distance)
        }
    }
    public var distanceTextGenerator: (Double) -> String = { distance in
        return "\(Int(distance)) m"
    }

    internal let distanceLabel: UILabel = {
        let label = UILabel().layoutable()
        label.textAlignment = .center
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupLayer()
        setupDistanceLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayer() {
        layer.backgroundColor = Constants.backgroundColor
        layer.borderColor = Constants.borderColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.masksToBounds = true
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

private extension SimplePOILabelView {
    enum Constants {
        static let width: CGFloat = 100
        static let height: CGFloat = 50

        static let backgroundColor: CGColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground.cgColor
            } else {
                return UIColor.white.cgColor
            }
        }()

        static let borderColor: CGColor = {
            if #available(iOS 13.0, *) {
                return UIColor.label.withAlphaComponent(0.5).cgColor
            } else {
                return UIColor.black.withAlphaComponent(0.5).cgColor
            }
        }()
    }
}
