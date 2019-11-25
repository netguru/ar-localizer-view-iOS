//
//  ATMLabelView.swift
//  ARLocalizerView
//

import UIKit
import ARLocalizerView

public final class ATMLabelView: UIView, POILabelView {
    public var name: String? {
        didSet {
            nameLabel.text = name
            nameLabelHeightContraint.constant = (name == nil) ? 0 : Constants.labelHeight
        }
    }

    public var distance: Double = 0 {
        didSet {
            distanceLabel.text = distanceTextGenerator(distance)
            alpha = appropriateAlpha
        }
    }
    public var distanceTextGenerator: (Double) -> String = { distance in
        return "\(Int(distance)) m"
    }

    internal var appropriateAlpha: CGFloat {
        switch distance {
        case 0 ..< 300:
            return 1
        case 300 ..< 600:
            return 0.7
        case 600 ..< 900:
            return 0.4
        default:
            return 0.1
        }
    }

    lazy private var nameLabelHeightContraint = nameLabel.heightAnchor.constraint(equalToConstant: 0)

    internal let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .light)
        return label
    }()

    internal let distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIFont.systemFontSize, weight: .medium)
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupLayer()
        setupNameLabel()
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

    private func setupNameLabel() {
        addSubview(nameLabel)
        activateConstaintsForNameLabel()
    }

    private func setupDistanceLabel() {
        addSubview(distanceLabel)
        activateConstaintsForDistanceLabel()
    }

    private func activateConstaintsForNameLabel() {
        NSLayoutConstraint.activate(
            [
                nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                nameLabel.widthAnchor.constraint(equalToConstant: Constants.width),
                nameLabelHeightContraint
            ]
        )
    }

    private func activateConstaintsForDistanceLabel() {
        NSLayoutConstraint.activate(
            [
                distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                distanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
                distanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
                distanceLabel.widthAnchor.constraint(equalToConstant: Constants.width),
                distanceLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
            ]
        )
    }
}

private extension ATMLabelView {
    enum Constants {
        static let width: CGFloat = 100
        static let labelHeight: CGFloat = 20

        static let backgroundColor: CGColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground.cgColor
            } else {
                return UIColor.white.cgColor
            }
        }()

        static let borderColor: CGColor = {
            if #available(iOS 13.0, *) {
                return UIColor.label.withAlphaComponent(0.3).cgColor
            } else {
                return UIColor.black.withAlphaComponent(0.3).cgColor
            }
        }()
    }
}
