//
//  NetworkError.swift
//  ARLocalizerView
//

import Foundation

enum NetworkError {
    case connectionError(Error)
    case noResponse
    case invalidResponse(URLResponse)
    case badRequest
    case moved
    case tooManyRequests
    case gatewayTimeout
    case invalidStatusCode(Int)
    case invalidPath(String)
    case downloadError

    var description: String {
        switch self {
        case .connectionError(let error):
            return "Connection Error: \(error.localizedDescription)"
        case .noResponse:
            return "Error: No Response"
        case .invalidResponse(let urlResponse):
            return "Invalid URLResponse: \(urlResponse.description)"
        case .badRequest:
            return "Error: Bad Request"
        case .moved:
            return "Error: Moved"
        case .tooManyRequests:
            return "Error: Too Many Requests"
        case .gatewayTimeout:
            return "Error: Gateway Timeout"
        case .invalidStatusCode(let statusCode):
            return "Invalid Status Code: \(statusCode)"
        case .invalidPath(let path):
            return "Invalid Path: \(path)"
        case .downloadError:
            return "Download Error"
        }
    }

    static func statusCodeError(statusCode: Int) -> NetworkError {
        switch statusCode {
        case 302:
            return moved
        case 400:
            return badRequest
        case 429:
            return tooManyRequests
        case 504:
            return gatewayTimeout
        default:
            return invalidStatusCode(statusCode)
        }
    }
}
