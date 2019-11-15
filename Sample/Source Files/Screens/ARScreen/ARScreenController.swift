//
//  ARScreenController.swift
//  ARLocalizerView
//

import UIKit
import ARLocalizerView

protocol ARScreenControllerDelegate: AnyObject {
    func didTapOnMapViewButton(arScreenController: ARScreenController)
}

final class ARScreenController: UIViewController {
    private let arViewController: ARViewController
    private weak var delegate: ARScreenControllerDelegate?

    init(arViewController: ARViewController, delegate: ARScreenControllerDelegate) {
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
        view = ARScreen(frame: UIScreen.main.bounds, arView: arViewController.view)
    }

    override func viewDidLoad() {
        guard let view = view as? ARScreen else { return }
        view.mapViewButton.addTarget(self, action: #selector(didTapOnMapViewButton), for: .touchUpInside)
    }

    @objc func didTapOnMapViewButton() {
        delegate?.didTapOnMapViewButton(arScreenController: self)
    }
}
