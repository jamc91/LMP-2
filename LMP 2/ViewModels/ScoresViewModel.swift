//
//  ScoresViewModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 30/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class ScoresViewModel {
    
    @Published var games = [Game]()
    @Published var loadingState: LoadingState = .loading
    
    init() {
        getScheduledGames()
    }
    
    func getScheduledGames(date: Date = Date()) {
        ApiService.shared.getData(with: EndPoint.schedule(date.dateFormatter())) { [weak self] (result: Result<ScheduleResponse, ApiError>) in
            switch result {
            case .success(let games):
                self?.loadingState = games.dates.isEmpty ? .empty : .loaded
                self?.games = games.dates.flatMap { $0.games }
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
