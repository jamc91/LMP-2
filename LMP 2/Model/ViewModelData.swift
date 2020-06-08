//
//  ViewModelData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 26/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var Results = [Response]()
    @Published var standingList = Standings()
    @Published var statisticsListBatting = [leadersBatting]()
    @Published var statisticsListPitching = [leadersPitching]()
    @Published var date = ""
    @Published var dateNow = Date()
    @Published var showPickerView = false
    
    
    
    func loadContent() {
        self.parseData()
        self.parseStandings()
        self.parseLeadersBatting(mode: "batting", type: "regular")
        self.parseLeadersPitching(mode: "pitching", type: "regular")
        
    }

    func parseData() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        self.date = formatter.string(from: self.dateNow)
        
        let url = URL(string: "https://api.lmp.mx/3.0.0/scoreboard/\(date)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                
                let games = try JSONDecoder().decode(ResultList.self, from: data)
                
                DispatchQueue.main.async {
                    
                    self.Results = games.response
                    
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
    
    func parseLeadersBatting(mode: String, type: String) {
                
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.lmp.mx"
        components.path = "/3.0.0/leaders"
        components.queryItems = [
        URLQueryItem(name: "mode", value: mode),
        URLQueryItem(name: "type", value: type),
        URLQueryItem(name: "limit", value: "300")
        ]
        let url = components.url
        
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
    
        func parseLeadersPitching(mode: String, type: String) {
                    
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.lmp.mx"
            components.path = "/3.0.0/leaders"
            components.queryItems = [
            URLQueryItem(name: "mode", value: mode),
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "limit", value: "300")
            ]
            let url = components.url
            
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



