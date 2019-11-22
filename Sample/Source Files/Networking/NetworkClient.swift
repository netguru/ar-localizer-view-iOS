//
//  NetworkClient.swift
//  ARLocalizerView
//

import Foundation

protocol NetworkClient {
    associatedtype RequestAttributes

    func getData(
        usingAttributes attributes: RequestAttributes,
        session: URLSessionProtocol,
        completion: @escaping (Data?, NetworkError?) -> Void
    )
}
