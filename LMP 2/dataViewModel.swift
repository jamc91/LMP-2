//
//  dataViewModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

class ResultsListViewModel: ObservableObject {
    
    @Published var resultsList = [Results]()
    
    func parseData() {
    
    guard let url = URL(string: "http://statsapi.mlb.com/api/v1/schedule?sportId=1&date=03/11/2019") else {
        fatalError("Invalid URL")
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            
            return
        }
        
        let FetchData = try? JSONDecoder().decode(Results.self, from: data)
        
        print(FetchData!)
    
        
    
            
            
        }.resume()
        
    }
   
    }




