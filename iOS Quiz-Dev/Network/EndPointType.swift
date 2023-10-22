//
//  EndPointType.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 21/10/23.
//
//
import Foundation

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var url: URL? { get }
}

extension EndPointType {
    var headers: [String: String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        return nil
    }
}
