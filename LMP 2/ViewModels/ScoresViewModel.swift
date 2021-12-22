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

final class ScoresViewModel: ObservableObject {
    
    @Published var games = [Game]()
    @Published var loadingState: LoadingState = .loading
    @Published var date = Date()
   // let timerManager = TimerManager()
    
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
    
    func refreshScores() {
        getScheduledGames(date: date)
        print("se han recargado los juegos.")
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
    
//    /// Detiene Timer.
//    func stopTimer() {
//        timerManager.stopTimer()
//    }
//
//    /// Inicia Timer.
//    func startTimer() {
//        timerManager.startTimer {
//            self.getScheduledGames(date: self.date)
//        }
//    }
//
//    func didTapCalendarButton() {
//      //  showDatePicker = true
//        stopTimer()
//    }

    func changeDate() {
            loadingState = .loading
            games.removeAll()
          //  showDatePicker = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.getScheduledGames(date: self.date)
        }
    }

//    func dismissCalendar() {
//        showDatePicker = false
//        startTimer()
//    }
}
