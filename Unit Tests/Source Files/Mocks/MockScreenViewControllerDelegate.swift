//
//  MockScreenViewControllerDelegate.swift
//  ARLocalizerView
//

import Foundation
@testable import ARLocalizerViewSample

class MockScreenViewControllerDelegate: MapScreenViewControllerDelegate, ARScreenViewControllerDelegate {
    var didTapOnButton: ((Bool) -> Void)?

    func didTapOnARViewButton(animateTransition: Bool) {
        didTapOnButton?(animateTransition)
    }

    func didTapOnMapViewButton(arScreenController: ARScreenViewController, animateTransition: Bool) {
        didTapOnButton?(animateTransition)
    }
}
