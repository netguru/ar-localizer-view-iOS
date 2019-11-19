//
//  CGRect+Diagonal.swift
//  ARLocalizerView
//

import UIKit

extension CGRect {
    var diagonal: CGFloat {
        return sqrt(pow(width, 2) + pow(height, 2))
    }
}
