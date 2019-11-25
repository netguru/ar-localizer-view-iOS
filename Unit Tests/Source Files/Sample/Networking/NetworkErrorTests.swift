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
            NetworkError.moved.description,
            "Network error with status code 302 should be a 'moved' network error."
        )
        XCTAssertEqual(
            NetworkError.statusCodeError(statusCode: 400).description,
            NetworkError.badRequest.description,
            "Network error with status code 400 should be a 'bad request' network error."
        )
        XCTAssertEqual(
            NetworkError.statusCodeError(statusCode: 429).description,
            NetworkError.tooManyRequests.description,
            "Network error with status code 429 should be a 'too many requests' network error."
        )
        XCTAssertEqual(
            NetworkError.statusCodeError(statusCode: 504).description,
            NetworkError.gatewayTimeout.description,
            "Network error with status code 504 should be a 'gateway timeout' network error."
        )
        XCTAssertEqual(
            NetworkError.statusCodeError(statusCode: 123).description,
            NetworkError.invalidStatusCode(123).description,
            "Network error with status code 123 should be an 'invalid status code' network error."
        )
    }

    func testDescriptions() {
        let response = URLResponse()
        XCTAssertEqual(
            NetworkError.invalidResponse(response).description,
            "Invalid URLResponse: \(response.description)",
            "Invalid response network error should have proper description."
        )
        let mockError = MockError()
        XCTAssertEqual(
            NetworkError.connectionError(mockError).description,
            "Connection Error: \(mockError.localizedDescription)",
            "Connection error should have proper description."
        )
        XCTAssertEqual(
            NetworkError.noResponse.description,
            "Error: No Response",
            "No response network error should have proper description."
        )
        XCTAssertEqual(
            NetworkError.badRequest.description,
            "Error: Bad Request",
            "Bad request network error should have proper description."
        )
        XCTAssertEqual(
            NetworkError.moved.description,
            "Error: Moved",
            "Moved network error should have proper description."
        )
        XCTAssertEqual(
            NetworkError.tooManyRequests.description,
            "Error: Too Many Requests",
            "Too many requests network error should have proper description."
        )
        XCTAssertEqual(
            NetworkError.gatewayTimeout.description,
            "Error: Gateway Timeout",
            "Gateway timeout network error should have proper description."
        )
        XCTAssertEqual(
            NetworkError.invalidStatusCode(123).description,
            "Invalid Status Code: 123",
            "Invalid status code network error should have proper description."
        )
        XCTAssertEqual(
            NetworkError.invalidPath("path").description,
            "Invalid Path: path",
            "Invalid path network error should have proper description."
        )
        XCTAssertEqual(
            NetworkError.downloadError.description,
            "Download Error",
            "Download error should have proper description."
        )
    }
}
