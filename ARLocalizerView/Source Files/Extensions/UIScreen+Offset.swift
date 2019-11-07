//
//  UIScreen+Offset.swift
//  ARLocalizerView
//

import UIKit

extension UIScreen {
    // Returns to how many pixels on screen should be translated every degree of azimuthal angle.
    // It is used to calculate the change in AR label's horizontal offset when user moves the phone horizontally.
    var pixelsForOneDegree: CGFloat {
        bounds.width / 40.0
    }

    // Returns to how many pixels on screen should be translated every 1/100th of gravitational force.
    // It is used to calculate the change in AR label's vertical offset when user tilts.
    var pixelsForOneHoundrethOfGravity: CGFloat {
        bounds.width / 70.0
    }
}
