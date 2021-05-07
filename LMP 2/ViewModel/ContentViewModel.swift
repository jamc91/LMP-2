//
//  ContentViewModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/20/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    
    /// Lista de juegos del dia.
    @Published var scheduledGames: [Game]
    /// Posiciones Liga MLB
    @Published var standingMLB: StandingMLB?
    /// Posiciones Liga LMP
    @Published var standingLMP: StandingLMP?
    /// Informacion de los juegos en vivo.
    @Published var live: LiveResponse?
    /// Informacion del contenido imagenes, videos etc....
    @Published var content: ContentResponse?
    /// Informa del estado de carga a la vista.
    @Published var posts: [Post]
    
    @Published var detailPost: Post?
    
    @Published var loadingState = LoadingState.loading
    
    @Published var showDatePicker = false
    @Published var showSheet = false
    
    @Published var showDetailView = false
    
    @Published var date = Date()
    
    private var timer: Timer?
    var timerStopped = false
    
    init(
        games: [Game] = [],
        standingMLB: StandingMLB? = nil,
        standingLMP: StandingLMP? = nil,
        liveContent: LiveResponse? = nil,
        videoList: ContentResponse? = nil,
        posts: [Post] = [],
        detailPost: Post? = nil
    ){
        self.scheduledGames = games
        self.standingMLB = standingMLB
        self.standingLMP = standingLMP
        self.live = liveContent
        self.content = videoList
        self.posts = posts
        self.detailPost = detailPost
        loadData()
    }

    /// Llama a todas las funciones para recuperar los datos.
    func loadData() {
        startTimer()
        getScheduledGames()
        getStandingsMLB()
        getStandingsLMP()
        getPosts(page: 1)
    }
    
    /// Recupera los juegos programados segun la fecha seleccionada.
    func getScheduledGames() {
        ApiService.shared.getData(with: EndPoint.schedule(date.dateFormatter())) { [weak self] (result: Result<ScheduleResponse, ApiError>) in
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

    /// Recupera las posiciones de la liga MLB.
    func getStandingsMLB() {
        ApiService.shared.getData(with: EndPoint.standingMLB) { [weak self] (result: Result<StandingMLB, ApiError>) in
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
        ApiService.shared.getData(with: EndPoint.standingLMP) { [weak self] (result: Result<StandingLMP, ApiError>) in
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
        ApiService.shared.getData(with: EndPoint.videoList("\(gamePk)")) { [weak self] (result: Result<ContentResponse, ApiError>) in
            switch result {
            case .success(let videos):
                self?.content = videos
            case .failure(let apiError):
                self?.printApiErrorMessage(error: apiError)
            }
        }
    }
    
    func getPosts(page: Int) {
        ApiService.shared.getData(with: EndPoint.posts(page)) { [weak self] (result: Result<PostsModel<Response>, ApiError>) in
            switch result {
            case .success(let posts):
                self?.posts.append(contentsOf: posts.response.posts)
            case .failure(let error):
                self?.printApiErrorMessage(error: error)
            }
        }
    }
    
    func getDetailPost(slug: String, completion: @escaping () -> Void) {
        ApiService.shared.getData(with: EndPoint.postDetail(slug)) { [weak self] (result: Result<PostsModel<Post>, ApiError>) in
            switch result {
            case .success(let posts):
                self?.detailPost = posts.response
                completion()
            case .failure(let error):
                self?.printApiErrorMessage(error: error)
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
        timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true, block: { _ in
            self.getScheduledGames()
        })
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
    
    func didTapCalendarButton() {
        showDatePicker = true
        stopTimer()
    }
    
    func changeDate() {
            loadingState = .loading
            scheduledGames.removeAll()
            showDatePicker = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.startTimer()
            self.getScheduledGames()
        }
    }
    
    func dismissCalendar() {
        showDatePicker = false
        startTimer()
    }
}
