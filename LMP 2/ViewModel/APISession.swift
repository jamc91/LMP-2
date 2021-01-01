//
//  APISession.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/20/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import Combine

class APISession {
    
    private var cancellables = Set<AnyCancellable>()
    
    func request<T: Codable>(with builder: RequestBuilder, completion: @escaping (T) -> Void) {
        URLSession.shared.dataTaskPublisher(for: builder.urlRequest)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        return Just(data)
                            .decode(type: T.self, decoder: JSONDecoder())
                            .mapError { _ in .decodingError }
                            .eraseToAnyPublisher()
                    } else {
                        return Fail(error: APIError.httpError(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                return Fail(error: APIError.unknown)
                    .eraseToAnyPublisher()
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
            .sink { result in
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .finished:
                    break
                }
            } receiveValue: { value in
                completion(value)
            }
            .store(in: &cancellables)
    }
}
