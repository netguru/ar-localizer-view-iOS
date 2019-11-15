//
//  NetworkClient.swift
//  ARLocalizerView
//

import Foundation

protocol NetworkClient {
    associatedtype RequestAttributes
    func getData(usingAttributes attributes: RequestAttributes, completion: @escaping (Data?, NetworkError?) -> Void)
}
