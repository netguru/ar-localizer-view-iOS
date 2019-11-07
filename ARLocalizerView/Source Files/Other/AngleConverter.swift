//
//  AngleConverter.swift
//  ARLocalizerView
//

import Foundation

class AngleConverter {
    static let shared = AngleConverter()

    func convertToDegrees(radians: Double) -> Angle {
        return radians * 180.0 / .pi
    }
}
