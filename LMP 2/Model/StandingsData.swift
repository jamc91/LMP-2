//
//  StandingsData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 21/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import SwiftUI

struct resultsStandings: Decodable, Hashable {
    
   var response: Standings
   
}

struct Standings: Decodable, Hashable {
    
   var first, second, general : [StandingRegular]
   var points                 : [StandingPoints]
   var playoffs               : Playoffs?
    
    init() {
        
        self.first = []
        self.second = []
        self.general = []
        self.points = []

    }
}

struct StandingRegular: Decodable, Hashable, Identifiable {
    
    var id        : String
    var name      : String
    var team_name : String
    var wins      : Int
    var losses    : Int
    var percent   : String
    var gb        : String
    var pts       : String

}

struct StandingPoints: Decodable, Hashable, Identifiable {
    
    var id        : String
    var name      : String
    var team_name : String
    var percent   : String
    var first     : String
    var second    : String
    var total     : String
}

struct Playoffs: Decodable, Hashable {
    
    var repesca, semifinal, final: [StandingPlayoffs]
    
}

struct StandingPlayoffs: Decodable, Hashable, Identifiable {
    
    var id                = UUID()
    var away_team_name    : String
    var away_image        : String
    var away_wins         : Int
    var away_losses       : Int
    var away_percent      : String
    var away_runs_avg     : String
    var away_games_played : String
    var home_team_name    : String
    var home_image        : String
    var home_wins         : Int
    var home_losses       : Int
    var home_percent      : String
    var home_runs_avg     : String
    var home_games_played : String
    
    enum CodingKeys: String, CodingKey {
        case away_team_name,away_image, away_wins, away_losses, away_percent, away_runs_avg, away_games_played, home_team_name,home_image, home_wins, home_losses, home_percent, home_runs_avg, home_games_played
    }
}
