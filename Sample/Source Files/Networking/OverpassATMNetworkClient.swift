//
//  ATMNetworkClient.swift
//  ARLocalizerView
//

import Foundation
import ARLocalizerView

final class OverpassATMNetworkClient: NetworkClient {
    typealias RequestAttributes = LocationBounds

    private let basePath = "https://overpass-api.de/api/interpreter"

    func requestPath(withAttributes attributes: RequestAttributes) -> String {
        var path = basePath
        path += "?data=node[amenity=atm]("
        path += "\(attributes.south),\(attributes.west),\(attributes.north),\(attributes.east)"
        path += ");out;"
        return path
    }

    func getData(
        usingAttributes attributes: RequestAttributes,
        session: URLSessionProtocol = URLSession.shared,
        completion: @escaping (Data?, NetworkError?) -> Void
    ) {
        let path = requestPath(withAttributes: attributes)
        guard let url = URL(string: path) else {
            completion(nil, .invalidPath(path))
            return
        }

        session.downloadFile(with: url) { localURL, response, error in
            if let error = error {
                completion(nil, .connectionError(error))
                return
            }
            guard let response = response else {
                completion(nil, .noResponse)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .invalidResponse(response))
                return
            }
            guard httpResponse.statusCode == 200 else {
                completion(nil, .statusCodeError(statusCode: httpResponse.statusCode))
                return
            }
            guard let localURL = localURL else {
                completion(nil, .downloadError)
                return
            }
            completion(try? Data(contentsOf: localURL), nil)
        }
    }
}
