//
//  MockURLSession.swift
//  ARLocalizerView
//

import Foundation
@testable import ARLocalizerViewSample

class MockSession: URLSessionProtocol {
    let url: URL?
    let urlResponse: URLResponse?
    let error: Error?

    init(url: URL?, urlResponse: URLResponse?, error: Error?) {
        self.url = url
        self.urlResponse = urlResponse
        self.error = error
    }

    func downloadFile(with url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) {
        completionHandler(self.url, urlResponse, error)
    }
}
