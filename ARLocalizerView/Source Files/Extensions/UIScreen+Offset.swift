//
//  UIScreen+Offset.swift
//  ARLocalizerView
//

import UIKit

extension UIScreen {
  var pixelsForOneDegree: Double {
    Double(bounds.width / 30.0)
  }
}
