//
//  EndPoint.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 21/10/23.
//

import Foundation
//import Alamofire
//
enum EndpointItem {
    case topNovelList(page: Int)
    case banner
}

extension EndpointItem: EndPointType {
    var baseURL: String {
        return "https://www.dek-d.com/api/rest/"
    }

    var path: String {
        switch self {
        case .topNovelList:
            return "open/quiz/novel/list"
        case .banner:
            return "campaign/list"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var headers: [String: String]? {
        switch self {
        case .topNovelList:
            return ["SECRET": "DrVDKp2ancYmyW2b3wRVU6yssBcjiyJ4"]
        default:
            return nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .topNovelList(let page):
            return ["page": page]
        default:
            return nil
        }
    }

    var url: URL? {
        return URL(string: self.baseURL + self.path)
    }
}

