//
//  UIView+Layout.swift
//  ARLocalizerView
//

import UIKit

extension UIView {
    /// Returns view with the same type that can be used with AutoLayout
    ///
    /// - Returns: Adjusted view
    func layoutable() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
