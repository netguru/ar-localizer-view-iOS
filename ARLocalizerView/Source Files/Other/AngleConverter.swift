//
//  AngleConverter.swift
//  ARLocalizerView
//

import Foundation

enum AngleConverter {
    static func convertToDegrees(radians: Double) -> Angle {
        return radians * 180.0 / .pi
    }
}
