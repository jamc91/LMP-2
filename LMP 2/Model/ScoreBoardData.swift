//
//  ScoreBoardData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct ResultList: Codable {
    
    var response: [Response]
    
}

struct Response: Codable, Identifiable, Hashable {
    
    var id = UUID()
    var gameStatus: Int
    var gameTime: String
    var awayTeam: String
    var awayRuns: Int
    var homeTeam: String
    var homeRuns: Int
    var diamond: String
    var balls: String
    var strikes: String
    var outs: String
    var inningArrow: String
    var inningCurrent: String
    
    enum CodingKeys: String, CodingKey {
        case gameStatus, gameTime, awayTeam, awayRuns, homeTeam, homeRuns, diamond, balls, strikes, outs, inningArrow, inningCurrent
    }
    
}


