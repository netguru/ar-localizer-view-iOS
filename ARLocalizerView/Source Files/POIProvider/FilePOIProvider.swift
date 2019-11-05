//
//  FilePOIProvider.swift
//  ARLocalizerView
//

import Foundation

final public class FilePOIProvider: POIProvider {
    public var pois: [POI]

    public init(fileURL: URL) {
        guard
            let data = try? Data(contentsOf: fileURL, options: .mappedIfSafe),
            let pois = try? JSONDecoder().decode([POI].self, from: data)
        else {
            self.pois = []
            return
        }

        self.pois = pois
    }
}
