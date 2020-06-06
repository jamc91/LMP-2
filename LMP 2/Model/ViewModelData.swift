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
    @Published var statisticsListRegular = [leadersRegular]()
    @Published var date = ""
    @Published var showPickerView = false
    @Published var dateNow = Date()
    



    func loadContent() {
        self.parseData()
        self.parseStandings()
        self.parseStatisticsRegular(mode: "batting", type: "regular", column: "avg")
    }

    func parseData() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        self.date = formatter.string(from: self.dateNow)
        
        let url = URL(string: "https://api.lmp.mx/3.0.0/scoreboard/\(self.date)")
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
    
    func parseStatisticsRegular(mode: String, type: String, column: String) {
        
        
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
    
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                
                let stat = try JSONDecoder().decode(statisticsRegular.self, from: data)
                        
                DispatchQueue.main.async {
                    
                    self.statisticsListRegular = stat.response
                
                }
                
            }
                
            catch {
                
                print(error.localizedDescription)
                
            }
        }.resume()
    }
    
 /*   func parseStatisticsPlayoffs() {
        
        let url = URL(string: "https://api.lmp.mx/3.0.0/leaders?mode=batting&type=playoffs&format=table-stats-batting&limit=300")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                
                let stat = try JSONDecoder().decode(statisticsPlayoffs.self, from: data)
                        
                DispatchQueue.main.async {
                    
                    self.statisticsListPlayoffs.append(contentsOf: stat.response)
                    
                }
            }
                
            catch {
                
                print(error.localizedDescription)
                
            }
        }.resume()
    }*/
    
}


