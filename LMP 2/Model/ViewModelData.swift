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
    
    @Published var Results = [Response]()
    @Published var standingList = Standings()
    @Published var statisticsListBatting = [leadersBatting]()
    @Published var statisticsListPitching = [leadersPitching]()
    @Published var date = ""
    @Published var dateNow = Date()
    @Published var showPickerView = false
    @Published var battingType = "regular"
    @Published var pitchingType = "regular"
    @Published var showActivityIndicator = false
    @Published var pickerBattingValue: Int = 0 {
        didSet {
            statisticsListBatting = []
            if let element = leadersBatting.battingCategories(rawValue: pickerBattingValue) {
                parseLeadersBatting(mode: "batting", type: battingType, column: "\(element)")
                
            }
        }
    }
    @Published var pickerPitchingValue: Int = 0 {
        didSet {
           statisticsListPitching = []
            if let element = leadersPitching.pitchingCategories(rawValue: pickerPitchingValue) {
                parseLeadersPitching(mode: "pitching", type: pitchingType, column: "\(element)")
            }
        }
    }
    
    
    func loadContent() {
        self.parseData()
        self.parseStandings()
        self.parseLeadersBatting(mode: "batting", type: "regular", column: "avg")
        self.parseLeadersPitching(mode: "pitching", type: "regular", column: "era")
        
    }

    func parseData() {
        showActivityIndicator = true
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        self.date = formatter.string(from: self.dateNow)
        print("hola")
        let url = URL(string: "https://api.lmp.mx/3.0.0/scoreboard/\(date)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                
                let games = try JSONDecoder().decode(ResultList.self, from: data)
                
                DispatchQueue.main.async {
                    
                    self.Results = games.response
                    self.showActivityIndicator = false
                 }
               }
                
            catch {
                
                print(error.localizedDescription)
                
            }
        }.resume()
    }
    
    func parseStandings() {
        
        let url = URL(string: "https://api.lmp.mx/3.0.0/standing")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                
                let standings = try JSONDecoder().decode(resultsStandings.self, from: data)
                        
                DispatchQueue.main.async {
                    
                    self.standingList = standings.response
                    
                }
            }
            catch {
                
                print(error.localizedDescription)
                
            }
        }.resume()
    }
    
    func parseLeadersBatting(mode: String, type: String, column: String) {
                
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.lmp.mx"
        components.path = "/3.0.0/leaders"
        components.queryItems = [
        URLQueryItem(name: "mode", value: mode),
        URLQueryItem(name: "type", value: type),
        URLQueryItem(name: "column", value: column)
        ]
        let url = components.url
        
        print(url!)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                
                let stat = try JSONDecoder().decode(statisticsBatting.self, from: data)
                        
                DispatchQueue.main.async {
                    
                    self.statisticsListBatting = stat.response
                    
                }
                
            }
                
            catch {
                
                print(error.localizedDescription)
                
            }
        }.resume()
    }
    
    func parseLeadersPitching(mode: String, type: String, column: String) {
                    
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.lmp.mx"
            components.path = "/3.0.0/leaders"
            components.queryItems = [
            URLQueryItem(name: "mode", value: mode),
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "column", value: column)
            ]
            let url = components.url
            print(url!)
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let data = data else { return }
                
                do {
                    
                    let stat = try JSONDecoder().decode(statisticsPitching.self, from: data)
                            
                    DispatchQueue.main.async {
                        
                        self.statisticsListPitching = stat.response
                        
                    }
                    
                }
                    
                catch {
                    
                    print(error.localizedDescription)
                    
                }
            }.resume()
        }
    }
