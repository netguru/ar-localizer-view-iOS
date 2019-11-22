//
//  POIExtractor.swift
//  ARLocalizerView
//

import Foundation
import ARLocalizerView

protocol POIExtractor {
    func extractPOIs(fromXMLData xmlData: Data, completion: @escaping ([POI]) -> Void)
}
