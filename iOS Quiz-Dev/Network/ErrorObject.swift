//
//  ErrorObject.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 21/10/23.
//

import Foundation

//class ErrorObject: Codable {
//    let message: String
//}

enum APIFailureCondition: Error {
    case invalidServerResponse
    case responseError
    case unknown
}

extension APIFailureCondition: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            return NSLocalizedString("Invalid URL", comment: "")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}
