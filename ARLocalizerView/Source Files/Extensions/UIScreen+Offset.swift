//
//  UIScreen+Offset.swift
//  ARLocalizerView
//

import UIKit

extension UIScreen {
  func xOffset(forDeviceAzimuth deviceAzimuth: Angle, andAzimutForPOI azimutForPOI: Angle) -> CGFloat {
    let pixelsForOneDegree = Double(bounds.width / 30.0)
    let offsetInDegrees = azimutForPOI.smallestDifference(to: deviceAzimuth)
    let offsetInPixels = offsetInDegrees * pixelsForOneDegree
    return CGFloat(offsetInPixels)
  }
}
