//
//  ContentViewModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/20/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import Combine

final class ContentViewModel: APISession, ObservableObject {
    
    /// Lista de juegos del dia.
    @Published var scheduledGames: [Games]
    /// Posiciones Liga MLB
    @Published var standingMLB: StandingMLB?
    /// Posiciones Liga LMP
    @Published var standingLMP: StandingLMP?
    /// Informacion de los juegos en vivo.
    @Published var liveContent = BoxscoreResponse()
    /// Informa del estado de carga a la vista.
    @Published var loadingState = ScoreboardLoadingState.loading
    
    @Published var videoList: VideoResponse?
    
    @Published var date = Date()
    
    private var timer: Timer?
    var timerStopped = false
    
    init(
        games: [Games] = [],
        standingMLB: StandingMLB? = nil,
        standingLMP: StandingLMP? = nil
    ){
        self.scheduledGames = games
        self.standingMLB = standingMLB
        self.standingLMP = standingLMP
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
        request(with: EndPoint.schedule(date.dateFormatter())) { (scheduledGames: ScoreboardModel) in
            self.loadingState = scheduledGames.dates.isEmpty ? .empty : .loaded

            if scheduledGames.totalGamesInProgress == 0 && !self.timerStopped {
                self.stopTimer()
            }
            self.scheduledGames = scheduledGames.dates.flatMap { $0.games }
        }
    }
    
    /// Recupera los datos de los juegos en vivo.
    func getLiveContent(gamePk: Int, completion: @escaping () -> Void) {
        request(with: EndPoint.live("\(gamePk)")) { (liveContent: BoxscoreResponse) in
            self.liveContent = liveContent
            completion()
        }
    }
    
    /// Recupera las posiciones de la liga MLB.
    func getStandingsMLB() {
        request(with: EndPoint.standingMLB) { (standingMLB: StandingMLB) in
            self.standingMLB = standingMLB
        }
    }
    
    /// Recupera las posiciones de la liga LMP.
    func getStandingsLMP() {
        request(with: EndPoint.standingLMP) { (standingLMP: StandingLMP) in
            self.standingLMP = standingLMP
        }
    }
    
    /// Recupera la lista de videos.
    func getVideoList(gamePk: Int, completion: @escaping () -> Void) {
        request(with: EndPoint.videoList("\(gamePk)")) { (videoList: VideoResponse) in
            self.videoList = videoList
            completion()
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
}
