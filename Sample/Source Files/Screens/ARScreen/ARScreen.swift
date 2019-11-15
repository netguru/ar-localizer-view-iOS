//
//  ARScreen.swift
//  ARLocalizerView
//

import UIKit
import ARLocalizerView

final class ARScreen: UIView {
    let mapViewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Return to map view", for: .normal)
        if #available(iOS 13.0, *) {
            button.layer.borderColor = UIColor.label.cgColor
        } else {
            button.layer.borderColor = UIColor.black.cgColor
        }
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    private let arView: UIView

    init(frame: CGRect, arView: UIView) {
        self.arView = arView
        super.init(frame: frame)
        backgroundColor = .black
        setupARView()
        setupMapViewButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupARView() {
        addSubview(arView)
        activateARViewConstraints()
    }

    private func setupMapViewButton() {
        addSubview(mapViewButton)
        activateMapViewButtonConstraints()
    }

    private func activateARViewConstraints() {
        NSLayoutConstraint.activate(
            [
                arView.topAnchor.constraint(equalTo: topAnchor),
                arView.bottomAnchor.constraint(equalTo: bottomAnchor),
                arView.leadingAnchor.constraint(equalTo: leadingAnchor),
                arView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        )
    }

    private func activateMapViewButtonConstraints() {
        NSLayoutConstraint.activate(
            [
                mapViewButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                mapViewButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                mapViewButton.widthAnchor.constraint(equalToConstant: 200),
                mapViewButton.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
    }
}
