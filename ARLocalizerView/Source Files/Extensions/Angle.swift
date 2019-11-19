//
//  Angle.swift
//  ARLocalizerView
//

import Foundation

public typealias Angle = Double

extension Angle {
    /// Calculates smallest difference between two angles.
    /// Returns positive value for countclockwise rotation or negative for clockwise.
    func smallestDifference(to angle: Angle) -> Angle {
        let difference = self - angle

        if difference > 180 {
            return difference - 360
        } else if difference < -180 {
            return difference + 360
        } else {
            return difference
        }
    }
}
