//
//  ApiService.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import Combine

class ApiService {
    
    static let shared = ApiService()
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}
    
    func getData<T: Codable>(with builder: RequestBuilder, completion: @escaping (Result<T, ApiError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(Formatter.formatterDate)
        URLSession.shared
            .dataTaskPublisher(for: builder.urlRequest)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<T, ApiError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        return Just(data)
                            .decode(type: T.self, decoder: decoder)
                            .mapError { .decodingError($0) }
                            .eraseToAnyPublisher()
                    } else {
                        return Fail(error: .httpError(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                return Fail(error: .unknown)
                    .eraseToAnyPublisher()
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
            .sink { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { value in
                completion(.success(value))
            }
            .store(in: &cancellables)
    }
}


