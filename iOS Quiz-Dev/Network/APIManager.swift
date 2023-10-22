//
//  APIManager.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 21/10/23.
//

import Foundation
import Combine

struct Response<T> {
    let value: T
    let response: URLResponse
}

class ServiceManager {
    static let shared = ServiceManager()
    private var cancellables = Set<AnyCancellable>()
    
    func call<T: Decodable>(endpoint: EndpointItem, type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in  // (4) -> Future Publisher
            guard let self = self, let url = endpoint.url else {
                return promise(.failure(APIFailureCondition.invalidServerResponse))
            }
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            endpoint.parameters?.forEach({
                guard let value = $0.value as? String else { return }
                components?.queryItems?.append(URLQueryItem(name: $0.key, value: value))
            })
            guard let finalUrl = components?.url else { return }
            var urlRequest = URLRequest(url: finalUrl)
            endpoint.headers?.forEach({
                urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
            })
            URLSession.shared.dataTaskPublisher(for: urlRequest) // (5) -> Publisher
                .tryMap { (data, response) -> Data in  // (6) -> Operator
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw APIFailureCondition.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())  // (7) -> Operator
                .receive(on: RunLoop.main) // (8) -> Sheduler Operator
                .sink(receiveCompletion: { (completion) in  // (9) -> Subscriber
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            print(decodingError.localizedDescription)
                            promise(.failure(decodingError))
                        case let apiError as APIFailureCondition:
                            print(apiError.localizedDescription)
                            promise(.failure(apiError))
                        default:
                            print("unknow error")
                            promise(.failure(APIFailureCondition.unknown))
                        }
                    }
                }, receiveValue: {  data in  // (10)
                    print(data)
                    promise(.success(data)
                    ) })
                .store(in: &self.cancellables)  // (11)
        }
    }
}
