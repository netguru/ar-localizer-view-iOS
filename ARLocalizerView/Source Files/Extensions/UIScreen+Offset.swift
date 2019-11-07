//
//  UIScreen+Offset.swift
//  ARLocalizerView
//

import UIKit

extension UIScreen {
    var pixelsForOneDegree: CGFloat {
        bounds.width / 40.0
    }

    var pixelsForOneHoundrethOfGravity: CGFloat {
        bounds.width / 70.0
    }
}
