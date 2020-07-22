//
//  ScoreBoardData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct ResultList: Codable {
    
    var response: [ScoreBoard]
    
}

struct ScoreBoard: Codable, Identifiable, Hashable {
    
    var id            = UUID()
    var gameStatus    : Int
    var gameTime      : String
    var awayTeam      : String
    var awayRuns      : Int
    var homeTeam      : String
    var homeRuns      : Int
    var diamond       : String
    var balls         : String
    var strikes       : String
    var outs          : String
    var inningArrow   : String
    var inningCurrent : String?
    
    enum CodingKeys: String, CodingKey {
        case gameStatus, gameTime, awayTeam, awayRuns, homeTeam, homeRuns, diamond, balls, strikes, outs, inningArrow
    }
    
    var diamondView: [String] {
        
        switch diamond {
        case "pos-001":
            return ["square", "square", "square.fill"]
        case "pos-011":
            return ["square", "square.fill", "square.fill"]
        case "pos-111":
            return ["square.fill", "square.fill", "square.fill"]
        case "pos-100":
            return ["square.fill", "square", "square.fill"]
        case "pos-010":
            return ["square", "square.fill", "square.fill"]
        case "pos-110":
            return ["square.fill", "square.fill", "square.fill"]
        case "pos-101":
            return ["square.fill", "square", "square.fill"]
        default:
            return ["square", "square", "square"]
        }
        
    }
    var inningCurrentOrdinal: String {
        switch inningCurrent {
        case "1":
            return "1ra"
        case "2":
            return "2da"
        case "3":
            return "3ra"
        case "4":
            return "4ta"
        case "5":
            return "5ta"
        case "6":
            return "6ta"
        case "7":
            return "7ma"
        case "8":
            return "8va"
        case "9":
            return "9na"
        case "10":
            return "10ma"
        case "11":
            return "11ma"
        case "12":
            return "12ma"
        case "13":
            return "13ra"
        case "14":
            return "14ta"
        case "15":
            return "15ta"
        case "16":
            return "16ta"
        case "17":
            return "17ma"
        case "18":
            return "18va"
        case "19":
            return "19na"
        default:
            return ""
        }
    }
    
    var strikesStatus: [String] {
        switch strikes {
        case "strikes-1":
            return ["circle.fill", "circle"]
        case "strikes-2":
            return ["circle.fill", "circle.fill"]
        default:
            return ["circle", "circle"]
            
        }
    }
    var ballsStatus: [String] {
        switch balls {
        case "balls-1":
            return ["circle.fill", "circle", "circle"]
        case "balls-2":
            return ["circle.fill", "circle.fill", "circle"]
        case "balls-3":
        return ["circle.fill", "circle.fill", "circle.fill"]
        default:
            return ["circle", "circle", "circle"]
            
        }
    }
    var outsStatus: [String] {
        switch outs {
        case "outs-1":
            return ["circle.fill", "circle"]
        case "outs-2":
            return ["circle.fill", "circle.fill"]
        default:
            return ["circle", "circle"]
            
        }
    }
}


