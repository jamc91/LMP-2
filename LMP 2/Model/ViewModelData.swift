//
//  ViewModelData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 26/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import URLImage

var url = "http://statsapi.mlb.com/api/v1/schedule?leagueId=132&sportId=17&date=11/6/2019&hydrate=team,linescore(matchup,runners),person,stats,probablePitcher,decisions" 

class ViewModel: ObservableObject {
    
    @Published var games = [ScoreBoard]()
    @Published var gamesMLB = [Dates]()
    @Published var standingList = Standings()
    @Published var leadersOfBattingList = [leadersBatting]()
    @Published var leadersOfPitchingList = [leadersPitching]()
    @Published var dateNow = Date()
    var timer = Timer()
    @Published var showPickerView = false
    @Published var showActivityIndicator = false
    @Published var showMainActivityIndicator = true
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
        URLImageService.shared.cleanFileCache()
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            self.fetchGames()
        }
        self.fetchGames()
        self.fetchStandings()
        self.fetchLeadersOfBatting()
        self.fetchLeadersOfPitching()
    
    }
        
    func fetchGames() {
        
        
        var date = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/d/YYYY"
        date = formatter.string(from: self.dateNow)
        
        if let url = URL(string: "https://statsapi.mlb.com/api/v1/schedule?language=es&sportId=1&date=\(date)&sortBy=gameDate&hydrate=team,linescore(matchup,runners),person,stats,probablePitcher,decisions") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                guard let data = data else {
                    fatalError("Error fetch games!")
                }
                
                do {
                    
                    let games = try JSONDecoder().decode(resultsMLB.self, from: data)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        
                        self.gamesMLB = games.dates
                        self.showActivityIndicator = false
                    })
                }
                    
                catch {
                    
                    print(error.localizedDescription)
                    debugPrint(error)
                }
            }.resume()
        }
    }
    
    func fetchStandings() {
        
        if let url = URL(string: "https://api.lmp.mx/3.0.0/standing") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    fatalError("Error fetch standings!")
                }
                
                do {
                    
                    let standings = try JSONDecoder().decode(resultsStandings.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        self.standingList = standings.response
                        self.showMainActivityIndicator = false
                        
                    }
                }
                catch {
                    
                    print(error.localizedDescription)
                    
                }
            }.resume()
        }
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
        if let url = components.url {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    fatalError("Error fetch leaders of batting!")
                }
                
                do {
                    
                    let leadersOfBatting = try JSONDecoder().decode(statisticsBatting.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        self.leadersOfBattingList = leadersOfBatting.response
                        
                    }
                    
                }
                    
                catch {
                    
                    print(error.localizedDescription)
                    
                }
            }.resume()
        }
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
        if let url = components.url {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    fatalError("Error fetch leaders of pitching!")
                }
                
                do {
                    
                    let leadersOfPitching = try JSONDecoder().decode(statisticsPitching.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        self.leadersOfPitchingList = leadersOfPitching.response
                        
                    }
                    
                }
                    
                catch {
                    
                    print(error.localizedDescription)
                    
                }
            }.resume()
        }
    }
}
