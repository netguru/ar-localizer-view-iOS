//
//  POIExtractor.swift
//  ARLocalizerView
//

import Foundation
import ARLocalizerView

final class OverpassATMExtractor: NSObject {
    private var pois: [POI] = []
}

extension OverpassATMExtractor: POIExtractor {
    func extractPOIs(fromXMLData xmlData: Data, completion: @escaping ([POI]) -> Void) {
        pois = []
        let parser = XMLParser(data: xmlData)
        parser.delegate = self
        parser.parse()
        completion(pois)
    }
}

extension OverpassATMExtractor: XMLParserDelegate {
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String] = [:]
    ) {
        guard
            elementName == "node",
            let latitudeString = attributeDict["lat"],
            let latitude = Double(latitudeString),
            let longitudeString = attributeDict["lon"],
            let longitude = Double(longitudeString)
        else {
            return
        }
        pois.append(
            POI(latitude: latitude, longitude: longitude)
        )
    }
}
