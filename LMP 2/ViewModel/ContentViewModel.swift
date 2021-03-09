//
//  ContentViewModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/20/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import Combine

final class ContentViewModel:APIService, ObservableObject {
    
    /// Lista de juegos del dia.
    @Published var scheduledGames: [Games]
    /// Posiciones Liga MLB
    @Published var standingMLB: StandingMLB?
    /// Posiciones Liga LMP
    @Published var standingLMP: StandingLMP?
    /// Informacion de los juegos en vivo.
    @Published var liveContent: BoxscoreResponse?
    /// Informa del estado de carga a la vista.
    @Published var loadingState = ScoreboardLoadingState.loading
    
    @Published var videoList: VideoResponse?
    
    @Published var date = Date()
    
    private var timer: Timer?
    var timerStopped = false
    
    init(
        games: [Games] = [],
        standingMLB: StandingMLB? = nil,
        standingLMP: StandingLMP? = nil,
        liveContent: BoxscoreResponse? = nil,
        videoList: VideoResponse? = nil
    ){
        self.scheduledGames = games
        self.standingMLB = standingMLB
        self.standingLMP = standingLMP
        self.liveContent = liveContent
        self.videoList = videoList
    }

    /// Llama a todas las funciones para recuperar los datos.
    func loadData() {
        startTimer()
        getScheduledGames()
        getStandingsMLB()
        getStandingsLMP()
    }
    
    /// Recupera los juegos programados segun la fecha seleccionada.
    func getScheduledGames() {
        getData(with: EndPoint.schedule(date.dateFormatter())) { [weak self] (result: Result<ScoreboardModel, APIError>) in
            switch result {
            case .success(let games):
                self?.loadingState = games.dates.isEmpty ? .empty : .loaded
                self?.scheduledGames = games.dates.flatMap { $0.games }
            case .failure(let apiError):
                self?.printApiErrorMessage(error: apiError)
            }
        }
    }
    
    /// Recupera los datos de los juegos en vivo.
    func getLiveContent(gamePk: Int, completion: @escaping () -> Void) {
        getData(with: EndPoint.live("\(gamePk)")) { [weak self] (result: Result<BoxscoreResponse, APIError>) in
            switch result {
            case .success(let liveData):
                self?.liveContent = liveData
                completion()
            case .failure(let apiError):
                self?.printApiErrorMessage(error: apiError)
            }
        }
    }

    /// Recupera las posiciones de la liga MLB.
    func getStandingsMLB() {
        getData(with: EndPoint.standingMLB) { [weak self] (result: Result<StandingMLB, APIError>) in
            switch result {
            case .success(let standingMLB):
                self?.standingMLB = standingMLB
            case .failure(let apiError):
                self?.printApiErrorMessage(error: apiError)
            }
        }
    }

    /// Recupera las posiciones de la liga LMP.
    func getStandingsLMP() {
        getData(with: EndPoint.standingLMP) { [weak self] (result: Result<StandingLMP, APIError>) in
            switch result {
            case .success(let standingLMP):
                self?.standingLMP = standingLMP
            case .failure(let apiError):
                self?.printApiErrorMessage(error: apiError)
            }
        }
    }

    /// Recupera la lista de videos.
    func getVideoList(gamePk: Int) {
        getData(with: EndPoint.videoList("\(gamePk)")) { [weak self] (result: Result<VideoResponse, APIError>) in
            switch result {
            case .success(let videos):
                self?.videoList = videos
            case .failure(let apiError):
                self?.printApiErrorMessage(error: apiError)
            }
        }
    }
    
    /// Detiene Timer.
    func stopTimer() {
        print("Timer Invalidado")
        timer?.invalidate()
        timer = nil
        timerStopped = true
    }
    
    /// Inicia Timer.
    func startTimer() {
        timerStopped = false
        print("Timer Inicializado")
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
            self.getScheduledGames()
        })
    }
    
    private func printApiErrorMessage(error: APIError) {
        switch error {
        case .decodingError:
            print("decoding Error")
        case .httpError(let statusCode):
            print("error http \(statusCode)")
        case .unknown:
            print("error desconocido")
        }
    }
}
