//
//  ViewModelData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 26/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var gamesMLB = [Dates]() {
        didSet {
            showActivityIndicator = false
        }
    }
    var timer = Timer()
    @Published var standingList = Standings()
    @Published var leadersOfBattingList = [leadersBatting]()
    @Published var leadersOfPitchingList = [leadersPitching]()
    @Published var standingMLBALList = [Records]()
    @Published var standingMLBNLList = [Records]()
    @Published var dateNow = Date()
    @Published var showPickerView = false
    @Published var showActivityIndicator = true
    @Published var requestLeadersOfBattingValue: (season   : leadersBatting.Season,
        category : leadersBatting.battingCategory) = (.regular, .avg) {
        didSet {
            leadersOfBattingList.removeAll()
            loadData(url: .leaders(mode: "batting", season: requestLeadersOfBattingValue.season.rawValue, category: requestLeadersOfBattingValue.category.rawValue, order: "desc")) { (leaders: statisticsBatting) in
                self.leadersOfBattingList = leaders.response
            }
        }
    }
    @Published var requestLeadersOfPitchingValue: (season   : leadersPitching.Season,
        category : leadersPitching.pitchingCategory) = (.regular, .era) {
        didSet {
            self.leadersOfPitchingList.removeAll()
            loadData(url: .leaders(mode: "pitching", season: requestLeadersOfPitchingValue.season.rawValue, category: requestLeadersOfPitchingValue.category.rawValue, order: "asc")) { (leaders: statisticsPitching) in
                self.leadersOfPitchingList = leaders.response
            }
        }
    }
    
    init() {
        loadData(url: URL(string: "https://statsapi.mlb.com/api/v1/standings?leagueId=103&standingsTypes=firstHalf,secondHalf,regularSeason&hydrate=division,team")!) { (StandingsMLB: StandingResultsMLB) in
            self.standingMLBALList = StandingsMLB.records
        }
        loadData(url: URL(string: "https://statsapi.mlb.com/api/v1/standings?leagueId=104&standingsTypes=firstHalf,secondHalf,regularSeason&hydrate=division,team")!) { (StandingsMLB: StandingResultsMLB) in
            self.standingMLBNLList = StandingsMLB.records
        }
        loadData(url: .games(date: self.dateNow.dateFormatter())) { (gamesMLB: resultsMLB) in
                self.gamesMLB = gamesMLB.dates
            }
        loadData(url: .standing) { (standing: resultsStandings) in
            self.standingList = standing.response
        }
        
        loadData(url: .leaders(mode: "batting", season: requestLeadersOfBattingValue.season.rawValue, category: requestLeadersOfBattingValue.category.rawValue, order: "desc")) { (leaders: statisticsBatting) in
            self.leadersOfBattingList = leaders.response
        }
        loadData(url: .leaders(mode: "pitching", season: requestLeadersOfPitchingValue.season.rawValue, category: requestLeadersOfPitchingValue.category.rawValue, order: "asc")) { (leaders: statisticsPitching) in
            
            self.leadersOfPitchingList = leaders.response
        }
        timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true, block: { _ in
           self.loadData(url: .games(date: self.dateNow.dateFormatter())) { (gamesMLB: resultsMLB) in
                if gamesMLB.totalGamesInProgress == 0 {
                    self.timer.invalidate()
                }
                self.gamesMLB = gamesMLB.dates
            }
        })
    }
    
    func loadData<T: Decodable>(url: URL, completion: @escaping (T) -> ()) {
        
        URLSession.shared.dataTask(with: url) { (data, respone, error) in
            
            guard let data = data else { return }
            
            do {
                
                let fetchData = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(fetchData)
                }
                
            } catch {
                
                debugPrint(error)
                
            }
        }.resume()
    }
}


