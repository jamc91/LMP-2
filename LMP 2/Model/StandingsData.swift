//
//  StandingsData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 21/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct resultsStandings: Decodable, Hashable {
   var response: Standings
   
}

struct Standings: Decodable, Hashable {
    
   var first: [First]
   var second: [Second]
   var general: [General]
   var points: [Points]
   var playoffs: PlayOffs?
    
    init() {
        
        self.first = []
        self.second = []
        self.general = []
        self.points = []

    }
}

struct First: Decodable, Hashable {
    
    var id: String
    var name: String
    var team_name: String
    var wins: Int
    var losses: Int
    var percent: String
    var gb: String
    var pts: String
    
}

struct Second: Decodable, Hashable {
    
    var id: String
    var name: String
    var team_name: String
    var wins: Int
    var losses: Int
    var percent: String
    var gb: String
    var pts: String
    
}
struct General: Decodable, Hashable {
    
    var id: String
    var name: String
    var team_name: String
    var wins: Int
    var losses: Int
    var percent: String
    var gb: String
    var pts: String
    
    
}

struct Points: Decodable, Hashable {
    
    var id: String
    var name: String
    var team_name: String
    var percent: String
    var first: String
    var second: String
    var total: String
}

struct PlayOffs: Decodable, Hashable {
    
    var repesca: [Repesca]
    var semifinal: [Semifinal]
    var final: [Final]
}

struct Repesca: Decodable, Hashable {
    
    var away_team_name: String
    var away_image: String
    var away_wins: Int
    var away_losses: Int
    var away_percent: String
    var away_runs_avg: String
    var away_games_played: String
    var home_team_name: String
    var home_image: String
    var home_wins: Int
    var home_losses: Int
    var home_percent: String
    var home_runs_avg: String
    var home_games_played: String
    
}

struct Semifinal: Decodable, Hashable {
    
    var away_team_name: String
    var away_image: String
    var away_wins: Int
    var away_losses: Int
    var away_percent: String
    var away_runs_avg: String
    var away_games_played: String
    var home_team_name: String
    var home_image: String
    var home_wins: Int
    var home_losses: Int
    var home_percent: String
    var home_runs_avg: String
    var home_games_played: String
    
}

struct Final: Decodable, Hashable {
    
    var away_team_name: String
    var away_image: String
    var away_wins: Int
    var away_losses: Int
    var away_percent: String
    var away_runs_avg: String
    var away_games_played: String
    var home_team_name: String
    var home_image: String
    var home_wins: Int
    var home_losses: Int
    var home_percent: String
    var home_runs_avg: String
    var home_games_played: String
    
}


