//
//  POILabelView.swift
//  ARLocalizerView
//

import UIKit

public protocol POILabelView: UIView {
    var name: String? { get set }
    var distance: Double? { get set }
}
