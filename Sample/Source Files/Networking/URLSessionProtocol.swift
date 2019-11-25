//
//  URLSessionProtocol.swift
//  ARLocalizerView
//

import Foundation

protocol URLSessionProtocol {
    func downloadFile(with url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void)
}

extension URLSession: URLSessionProtocol {
    func downloadFile(with url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) {
        let task = downloadTask(with: url) { url, response, error in
            completionHandler(url, response, error)
        }
        task.resume()
    }
}
