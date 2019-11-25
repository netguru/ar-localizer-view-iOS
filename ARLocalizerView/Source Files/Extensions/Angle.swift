//
//  Angle.swift
//  ARLocalizerView
//

import Foundation

public typealias Angle = Double

extension Angle {
    /// Calculates smallest distance between two angles.
    /// Returns positive value for counterclockwise rotation or negative for clockwise.
    func angularDistance(to angle: Angle) -> Angle {
        let difference = self - angle

        if difference > 180 {
            return difference - 360
        } else if difference < -180 {
            return difference + 360
        } else {
            return difference
        }
    }

    var positiveAngle: Angle {
        var angle = self
        while angle < 0 {
            angle += 360
        }
        while angle > 360 {
            angle -= 360
        }
        return angle
    }
}
