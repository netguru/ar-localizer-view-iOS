//
//  ARScreenController.swift
//  ARLocalizerView
//

import UIKit
import ARLocalizerView

protocol ARScreenViewControllerDelegate: AnyObject {
    func didTapOnMapViewButton(arScreenController: ARScreenViewController, animateTransition: Bool)
}

extension ARScreenViewControllerDelegate {
    func didTapOnMapViewButton(arScreenController: ARScreenViewController) {
        didTapOnMapViewButton(arScreenController: arScreenController, animateTransition: true)
    }
}

final class ARScreenViewController: UIViewController {
    private let arViewController: ARViewController
    private weak var delegate: ARScreenViewControllerDelegate?

    init(arViewController: ARViewController, delegate: ARScreenViewControllerDelegate) {
        self.arViewController = arViewController
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        addChild(arViewController)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ARScreenView(frame: UIScreen.main.bounds, arView: arViewController.view)
    }

    override func viewDidLoad() {
        guard let view = view as? ARScreenView else {
            return
        }
        view.mapViewButton.addTarget(self, action: #selector(didTapOnMapViewButton), for: .touchUpInside)
    }

    @objc func didTapOnMapViewButton() {
        delegate?.didTapOnMapViewButton(arScreenController: self)
    }
}
