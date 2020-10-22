//
//  ViewModelData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 26/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    @Published var contentMLB = ContentResults() 
    @Published var gamesMLB = [Dates]() {
        didSet {
            showActivityIndicator = false
        }
    }
    var timer = Timer()
    @Published var gamesLMP = [GamesLMP]()
    @Published var isPresentContent = false
    @Published var standingList = Standings()
    @Published var leadersOfBattingList = [leadersBatting]()
    @Published var leadersOfPitchingList = [leadersPitching]()
    @Published var standingMLBALList = StandingResultsMLB()
    @Published var date = Date()
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
        fetchData(url: .gamesLink(date: date.dateFormatter()), placeholder: ScoreboardResults.default) { (game: ScoreboardResults) in
            self.gamesMLB = game.dates
            
        }
        fetchData(url: .standing, placeholder: standingList) { (standing: Standings) in
            self.standingList = standing
        }
        
        fetchData(url: URL(string: "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&standingsTypes=firstHalf,secondHalf,regularSeason&hydrate=division,team")!, placeholder: standingMLBALList) { (standingMLB: StandingResultsMLB) in
            self.standingMLBALList = standingMLB
        }
        
        loadData(url: .leaders(mode: "batting", season: requestLeadersOfBattingValue.season.rawValue, category: requestLeadersOfBattingValue.category.rawValue, order: "desc")) { (leaders: statisticsBatting) in
            self.leadersOfBattingList = leaders.response
        }
        loadData(url: .leaders(mode: "pitching", season: requestLeadersOfPitchingValue.season.rawValue, category: requestLeadersOfPitchingValue.category.rawValue, order: "asc")) { (leaders: statisticsPitching) in
            
            self.leadersOfPitchingList = leaders.response
        }
        timerStatus(state: false)
    }
    
    func loadData<T: Codable>(url: URL, completion: @escaping (T) -> ()) {
        
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
    
    func fetchData<T: Codable>(url: URL, placeholder: T, completion: @escaping (T) -> ()) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .replaceError(with: placeholder)
            .receive(on: RunLoop.main)
            .sink(receiveValue: completion)
            .store(in: &cancellable)
    }

    func timerStatus(state: Bool) {
        if state {
            timer.invalidate()
            print("Timer Invalidate")
        } else {
            print("Timer Enabled")
            timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true, block: { _ in
                self.fetchData(url: .gamesLink(date: self.date.dateFormatter() ), placeholder: ScoreboardResults.default) { (games: ScoreboardResults) in
                    if games.totalGamesInProgress == 0 {
                        self.timer.invalidate()
                        print("Timer Invalidate")
                    }
                    self.gamesMLB = games.dates
                    
                }
            })
        }
    }
}


