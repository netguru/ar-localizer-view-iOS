//
//  OverpassATMNetworkClientTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerViewSample

class OverpassATMNetworkClientTests: XCTestCase {
    let requestAttributes = (south: 12.3, west: 45.6, north: 78.9, east: 1.2)
    let fileURL = Bundle.main.url(forResource: "NetguruOffices", withExtension: "json")!
    let url = URL(string: "https://netguru.com")!

    var networkClient: OverpassATMNetworkClient!

    override func setUp() {
        super.setUp()
        networkClient = OverpassATMNetworkClient()
    }
    func testGeneratingRequestPath() {
        XCTAssertEqual(
            networkClient.requestPath(withAttributes: requestAttributes),
            "https://overpass-api.de/api/interpreter?data=node[amenity=atm](12.3,45.6,78.9,1.2);out;",
            "The request path should be equal 'https://overpass-api.de/api/interpreter?data=node[amenity=atm](12.3,45.6,78.9,1.2);out;'"
        )
    }

    func testConnectionError() {
        let mockError = MockError()
        networkClient.getData(
            usingAttributes: requestAttributes,
            session: MockSession(url: nil, urlResponse: nil, error: mockError)
        ) { _, networkError in
            XCTAssertEqual(
                networkError?.description,
                NetworkError.connectionError(mockError).description,
                "Network client should return connection error."
            )
        }
    }

    func testNoResponseError() {
        networkClient.getData(
            usingAttributes: requestAttributes,
            session: MockSession(url: nil, urlResponse: nil, error: nil)
        ) { _, networkError in
            XCTAssertEqual(
                networkError?.description,
                NetworkError.noResponse.description,
                "Network client should return no response error."
            )
        }
    }

    func testInvalidResponseError() {
        let response = URLResponse()
        networkClient.getData(
            usingAttributes: requestAttributes,
            session: MockSession(url: nil, urlResponse: response, error: nil)
        ) { _, networkError in
            XCTAssertEqual(
                networkError?.description,
                NetworkError.invalidResponse(response).description,
                "Network client should return invalid response error."
            )
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
            XCTAssertEqual(
                networkError?.description,
                NetworkError.statusCodeError(statusCode: 300).description,
                "Network client should return status code error."
            )
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
            XCTAssertEqual(
                networkError?.description,
                NetworkError.downloadError.description,
                "Network client should return download error."
            )
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
            XCTAssertNotNil(data, "The returned data should be nil.")
        }
    }
}
