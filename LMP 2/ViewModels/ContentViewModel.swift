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
    @Published var games: [Game]
    /// Posiciones Liga MLB
    @Published var standingMLB: StandingMLB?
    /// Posiciones Liga LMP
    @Published var standingLMP: StandingLMP?
    /// Informa del estado de carga a la vista.
    @Published var posts: [Post]
    
    @Published var detailPost: Post?
    
    @Published var loadingState = LoadingState.loading
    
    @Published var showDatePicker = false
    @Published var showSheet = false
    
    @Published var showDetailView = false
    
    @Published var date = Date()
    
    /// ViewModels
    let timerManager = TimerManager()
    let scoresViewModel = ScoresViewModel()
    let standingsViewModel = StandingsViewModel()
    let newsViewModel = NewsViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        games: [Game] = [],
        standingMLB: StandingMLB? = nil,
        standingLMP: StandingLMP? = nil,
        posts: [Post] = [],
        detailPost: Post? = nil
    ){
        self.games = games
        self.standingMLB = standingMLB
        self.standingLMP = standingLMP
        self.posts = posts
        self.detailPost = detailPost
        loadData()
    }

    /// Llama a todas las funciones para recuperar los datos.
    func loadData() {
        startTimer()
        addSuscribers()
        getPosts(page: 1)
    }
    
    private func addSuscribers() {
        scoresViewModel.$games
            .assign(to: \.games, on: self)
            .store(in: &cancellables)
        
        scoresViewModel.$loadingState
            .assign(to: \.loadingState, on: self)
            .store(in: &cancellables)
        
        standingsViewModel.$standingLMP
            .assign(to: \.standingLMP, on: self)
            .store(in: &cancellables)
        
        standingsViewModel.$standingMLB
            .assign(to: \.standingMLB, on: self)
            .store(in: &cancellables)
        
        newsViewModel.$posts
            .assign(to: \.posts, on: self)
            .store(in: &cancellables)
        
        newsViewModel.$detailPost
            .assign(to: \.detailPost, on: self)
            .store(in: &cancellables)
    }
    
    func getPosts(page: Int) {
        newsViewModel.getPosts(page: page)
    }
    
    func getDetailPost(slug: String, completion: @escaping () -> Void) {
        newsViewModel.getDetailPost(slug: slug, completion: completion)
    }
    
    /// Detiene Timer.
    func stopTimer() {
        timerManager.stopTimer()
    }
    
    /// Inicia Timer.
    func startTimer() {
        timerManager.startTimer {
            self.scoresViewModel.getScheduledGames(date: self.date)
        }
    }
    
    func didTapCalendarButton() {
        showDatePicker = true
        stopTimer()
    }
    
    func changeDate() {
            loadingState = .loading
            games.removeAll()
            showDatePicker = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.startTimer()
            self.scoresViewModel.getScheduledGames(date: self.date)
        }
    }
    
    func dismissCalendar() {
        showDatePicker = false
        startTimer()
    }
}
