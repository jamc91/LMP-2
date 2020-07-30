//
//  ViewModelData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 26/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    private var cancellable: [AnyCancellable] = []
    @Published var gamesMLB = [Dates]()
    @Published var standingList = Standings()
    @Published var leadersOfBattingList = [leadersBatting]()
    @Published var leadersOfPitchingList = [leadersPitching]()
    @Published var dateNow = Date()
    var timer = Timer()
    @Published var showPickerView = false
    @Published var showActivityIndicator = false
    @Published var requestLeadersOfBattingValue: (season   : leadersBatting.Season,
        category : leadersBatting.battingCategory) = (.regular, .avg) {
        didSet {
            leadersOfBattingList.removeAll()
            fetchLeadersOfBatting(season: requestLeadersOfBattingValue.season.rawValue,
                                  column: requestLeadersOfBattingValue.category.rawValue)
        }
    }
    @Published var requestLeadersOfPitchingValue: (season   : leadersPitching.Season,
        category : leadersPitching.pitchingCategory) = (.regular, .era) {
        didSet {
            leadersOfPitchingList.removeAll()
            fetchLeadersOfPitching(season: requestLeadersOfPitchingValue.season.rawValue,
                                   column: requestLeadersOfPitchingValue.category.rawValue)
        }
    }
    func loadContent() {
        
        self.fetchGames()
        self.fetchStandings()
        self.fetchLeadersOfBatting()
        self.fetchLeadersOfPitching()
        self.timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { _ in
            self.fetchGames()
        }
    }
    
    func fetchGames() {
        
        var date = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/d/YYYY"
        date = formatter.string(from: self.dateNow)
        print(date)
        let urlString = URL(string: "https://statsapi.mlb.com/api/v1/schedule?language=es&sportId=1&date=\(date)&sortBy=gameDate&hydrate=team,linescore(matchup,runners),person,stats,probablePitcher,decisions")
        
        guard let url = urlString else { fatalError("error url!!") }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: resultsMLB.self, decoder: JSONDecoder())
            .map {$0.dates}
            .replaceError(with: gamesMLB)
            .receive(on: RunLoop.main)
            .assign(to: \.gamesMLB, on: self)
            .store(in: &cancellable)
    }
    
    func fetchStandings() {
        
        let urlString = URL(string: "https://api.lmp.mx/3.0.0/standing")
        
        guard let url = urlString else { fatalError("error url!!") }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: resultsStandings.self, decoder: JSONDecoder())
            .map {$0.response}
            .replaceError(with: standingList)
            .receive(on: RunLoop.main)
            .assign(to: \.standingList, on: self)
            .store(in: &cancellable)
    }
    
    func fetchLeadersOfBatting(season: String = "regular", column: String = "avg") {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.lmp.mx"
        components.path = "/3.0.0/leaders"
        components.queryItems = [
            URLQueryItem(name: "mode", value: "batting"),
            URLQueryItem(name: "type", value: season),
            URLQueryItem(name: "column", value: column)
        ]
        
        guard let url = components.url else { fatalError("Error URL") }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: statisticsBatting.self, decoder: JSONDecoder())
            .map { $0.response }
            .replaceError(with: leadersOfBattingList)
            .receive(on: RunLoop.main)
            .assign(to: \.leadersOfBattingList, on: self)
            .store(in: &cancellable)
    }
    func fetchLeadersOfPitching(season: String = "regular", column: String = "era") {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.lmp.mx"
        components.path = "/3.0.0/leaders"
        components.queryItems = [
            URLQueryItem(name: "mode", value: "pitching"),
            URLQueryItem(name: "type", value: season),
            URLQueryItem(name: "column", value: column)
        ]
        
        guard let url = components.url else { fatalError("Error URL") }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: statisticsPitching.self, decoder: JSONDecoder())
            .map { $0.response }
            .replaceError(with: leadersOfPitchingList)
            .receive(on: RunLoop.main)
            .assign(to: \.leadersOfPitchingList, on: self)
            .store(in: &cancellable)
    }
}
