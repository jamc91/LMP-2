//
//  ViewModelData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 26/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

class RowViewModel: ObservableObject {
    
    @Published var Results = [Response]()
    @Published var standingList = Standings()
    @Published var staticticsList = [Leaders]()
    @Published var date = ""
    @Published var showPickerView = false
    @Published var dateNow = Date()
    @Published var showSelector = false
    @Published var standingIs = "Regular"
    @Published var standingType = 0
    @Published var isLoading = false
    
    init() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        self.date = formatter.string(from: self.dateNow)
        
    }
    
    func parseData() {
        
        isLoading = true
        let url = URL(string: "https://api.lmp.mx/3.0.0/scoreboard/\(self.date)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                
                let fetched = try JSONDecoder().decode(ResultList.self, from: data)
                
                DispatchQueue.main.async {
                    
                    self.Results = fetched.response
                    self.isLoading = false
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
                
                let stand = try JSONDecoder().decode(resultsStandings.self, from: data)
                        
                DispatchQueue.main.async {
                    
                    self.standingList = stand.response
                    
                }
                
            }
                
            catch {
                
                print(error.localizedDescription)
                
            }
        }.resume()
    }
    
    func parseStatistics() {
        
        let url = URL(string: "https://api.lmp.mx/3.0.0/leaders?mode=batting&type=regular&format=table-stats-batting&limit=300")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                
                let stat = try JSONDecoder().decode(statistics.self, from: data)
                        
                DispatchQueue.main.async {
                    
                
                    self.staticticsList = stat.response
                    
                    
                }
                
            }
                
            catch {
                
                print(error.localizedDescription)
                
            }
        }.resume()
    }
    
}




