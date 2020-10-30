//
//  statisticsData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 01/06/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct statisticsBatting: Codable {
    
    var response: [leadersBatting]
    
}

struct leadersBatting: Codable, Identifiable {
    
    var id        = UUID()
    var name      : String
    var team      : String
    var team_name : String
    var img       : URL
    var thumb     : URL
    var pos       : String
    var avg       : String
    var r         : String
    var hr        : String
    var rbi       : String
    var sb        : String
    
    enum CodingKeys: String, CodingKey {
        case name, team, team_name, img, thumb, pos, avg, r, hr, rbi, sb
    }
    
    enum battingCategory: String, CaseIterable, Identifiable {
        
        case avg
        case r
        case hr
        case rbi
        case sb
        
        var id: String { self.rawValue }
    }
    
    enum Season: String, CaseIterable, Identifiable {
        case regular
        case playoffs
        
        var id: String { self.rawValue }
    }
    
    func getValue(picker: battingCategory) -> String {
        
        switch picker {
        case .r:
            return r
        case .hr:
            return hr
        case .rbi:
            return rbi
        case .sb:
            return sb
        default:
            return avg
        }
    }
    
    
}

struct statisticsPitching: Codable {
    
    var response: [leadersPitching]
    
}

struct leadersPitching: Codable, Identifiable {
    
    var id = UUID()
    
    var name      : String
    var team      : String
    var team_name : String
    var img       : URL
    var thumb     : URL
    var era       : String
    var w         : String
    var so        : String
    var sv        : String
    var whip      : String
    
    enum CodingKeys: String, CodingKey {
        case name, team, team_name, img, thumb, w, era, so, sv, whip
    }
    
    enum pitchingCategory: String, CaseIterable, Identifiable {
        case era
        case w
        case so
        case sv
        case whip
        
        var id: String { self.rawValue }
        
    }
    
    enum Season: String, CaseIterable, Identifiable {
        case regular
        case playoffs
        
        var id: String { self.rawValue }
    }
    
    func getValue(picker: pitchingCategory) -> String {
        
        switch picker {
        case .w:
            return w
        case .so:
            return so
        case .sv:
            return sv
        case .whip:
            return whip
        default:
            return era
        }
    }
}

