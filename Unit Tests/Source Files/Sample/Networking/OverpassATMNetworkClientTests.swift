//
//  OverpassATMNetworkClientTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerViewSample

class OverpassATMNetworkClientTests: XCTestCase {
    let networkClient = OverpassATMNetworkClient()
    let requestAttributes = (south: 12.3, west: 45.6, north: 78.9, east: 1.2)
    let fileURL = Bundle.main.url(forResource: "NetguruOffices", withExtension: "json")!
    let url = URL(string: "https://netguru.com")!

    func testGeneratingRequestPath() {
        XCTAssertEqual(
            networkClient.requestPath(withAttributes: requestAttributes),
            "https://overpass-api.de/api/interpreter?data=node[amenity=atm](12.3,45.6,78.9,1.2);out;"
        )
    }

    func testConnectionError() {
        networkClient.getData(
            usingAttributes: requestAttributes,
            session: MockSession(url: nil, urlResponse: nil, error: MockError())
        ) { _, networkError in
            XCTAssertEqual(networkError?.description, NetworkError.connectionError(MockError()).description)
        }
    }

    func testNoResponseError() {
        networkClient.getData(
            usingAttributes: requestAttributes,
            session: MockSession(url: nil, urlResponse: nil, error: nil)
        ) { _, networkError in
            XCTAssertEqual(networkError?.description, NetworkError.noResponse.description)
        }
    }

    func testInvalidResponseError() {
        let response = URLResponse()
        networkClient.getData(
            usingAttributes: requestAttributes,
            session: MockSession(url: nil, urlResponse: response, error: nil)
        ) { _, networkError in
            XCTAssertEqual(networkError?.description, NetworkError.invalidResponse(response).description)
        }
    }

    func testInvalidStatusCodeError() {
        let response = HTTPURLResponse(
            url: url,
            statusCode: 300,
            httpVersion: nil,
            headerFields: nil
        )
        networkClient.getData(
            usingAttributes: requestAttributes,
            session: MockSession(url: nil, urlResponse: response, error: nil)
        ) { _, networkError in
            XCTAssertEqual(networkError?.description, NetworkError.statusCodeError(statusCode: 300).description)
        }
    }

    func testDownloadError() {
        let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        networkClient.getData(
            usingAttributes: requestAttributes,
            session: MockSession(url: nil, urlResponse: response, error: nil)
        ) { _, networkError in
            XCTAssertEqual(networkError?.description, NetworkError.downloadError.description)
        }
    }

    func testSuccess() {
        let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        networkClient.getData(
            usingAttributes: requestAttributes,
            session: MockSession(url: fileURL, urlResponse: response, error: nil)
        ) { data, _ in
            XCTAssertNotNil(data)
        }
    }
}
