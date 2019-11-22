//
//  NetworkErrorTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerViewSample

class NetworkErrorTests: XCTestCase {
    func testStatusCodeErrors() {
        XCTAssertEqual(
            NetworkError.statusCodeError(statusCode: 302).description,
            NetworkError.moved.description
        )
        XCTAssertEqual(
            NetworkError.statusCodeError(statusCode: 400).description,
            NetworkError.badRequest.description
        )
        XCTAssertEqual(
            NetworkError.statusCodeError(statusCode: 429).description,
            NetworkError.tooManyRequests.description
        )
        XCTAssertEqual(
            NetworkError.statusCodeError(statusCode: 504).description,
            NetworkError.gatewayTimeout.description
        )
        XCTAssertEqual(
            NetworkError.statusCodeError(statusCode: 123).description,
            NetworkError.invalidStatusCode(123).description
        )
    }

    func testDescriptions() {
        XCTAssertEqual(
            NetworkError.connectionError(MockError()).description,
            "Connection Error: \(MockError().localizedDescription)"
        )
        XCTAssertEqual(
            NetworkError.noResponse.description,
            "Error: No Response"
        )
        XCTAssertEqual(
            NetworkError.invalidResponse(URLResponse()).description,
            "Invalid URLResponse: \(URLResponse().description)"
        )
        XCTAssertEqual(
            NetworkError.badRequest.description,
            "Error: Bad Request"
        )
        XCTAssertEqual(
            NetworkError.moved.description,
            "Error: Moved"
        )
        XCTAssertEqual(
            NetworkError.tooManyRequests.description,
            "Error: Too Many Requests"
        )
        XCTAssertEqual(
            NetworkError.gatewayTimeout.description,
            "Error: Gateway Timeout"
        )
        XCTAssertEqual(
            NetworkError.invalidStatusCode(123).description,
            "Invalid Status Code: 123"
        )
        XCTAssertEqual(
            NetworkError.invalidPath("path").description,
            "Invalid Path: path"
        )
        XCTAssertEqual(
            NetworkError.downloadError.description,
            "Download Error"
        )
    }
}
