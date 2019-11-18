//
//  POIExtractor.swift
//  ARLocalizerView
//

import Foundation
import ARLocalizerView

final class OverpassATMExtractor: NSObject {
    private var pois: [POI] = []
    private var currentlyParsedPOI: POI?
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
        if elementName == "node" {
            parseNodeElement(withAttributes: attributeDict)
        } else if elementName == "tag" {
            parseTagElement(withAttributes: attributeDict)
        }
    }

    private func parseNodeElement(withAttributes attributeDict: [String: String]) {
        guard
            let latitudeString = attributeDict["lat"],
            let latitude = Double(latitudeString),
            let longitudeString = attributeDict["lon"],
            let longitude = Double(longitudeString)
        else {
            return
        }

        currentlyParsedPOI = POI(latitude: latitude, longitude: longitude)

    }

    private func parseTagElement(withAttributes attributeDict: [String: String]) {
        guard attributeDict["k"] == "name" else {
            return
        }
        currentlyParsedPOI?.name = attributeDict["v"]
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        guard
            elementName == "node",
            let currentlyParsedPOI = currentlyParsedPOI
        else {
            return
        }

        pois.append(currentlyParsedPOI)
        self.currentlyParsedPOI = nil
    }
}
