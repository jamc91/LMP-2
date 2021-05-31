//
//  LiveViewModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 30/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

final class LiveViewModel {
    
    @Published var live: LiveResponse?
    @Published var content: ContentResponse?
    
    
    /// Recupera los datos de los juegos en vivo.
    func getLiveContent(gamePk: Int, completion: @escaping () -> Void) {
        ApiService.shared.getData(with: EndPoint.live("\(gamePk)")) { [weak self] (result: Result<LiveResponse, ApiError>) in
            switch result {
            case .success(let liveData):
                self?.live = liveData
                completion()
            case .failure(let apiError):
                self?.printApiErrorMessage(error: apiError)
            }
        }
    }
    
    func getVideoList(gamePk: Int) {
        ApiService.shared.getData(with: EndPoint.videoList("\(gamePk)")) { [weak self] (result: Result<ContentResponse, ApiError>) in
            switch result {
            case .success(let videos):
                self?.content = videos
            case .failure(let apiError):
                self?.printApiErrorMessage(error: apiError)
            }
        }
    }
    
    private func printApiErrorMessage(error: ApiError) {
        switch error {
        case .decodingError(let errorDecoding):
            debugPrint(errorDecoding)
        case .httpError(let statusCode):
            print("error http \(statusCode)")
        case .unknown:
            print("error desconocido")
        }
    }
}
