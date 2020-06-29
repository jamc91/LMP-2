//
//  statisticsData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 01/06/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct statisticsBatting: Decodable {
    
    var response: [leadersBatting]
    
}

struct leadersBatting: Decodable, Identifiable, Hashable {
    
    var id = UUID()
    var name: String
    var team: String
    var team_name: String
    var img: URL
    var thumb: URL
    var pos: String
    var avg: String
    var r: String
    var hr: String
    var rbi: String
    var sb: String
    
    enum CodingKeys: String, CodingKey {
        case name, team, team_name, img, thumb, pos, avg, r, hr, rbi, sb
    }
    
    enum battingCategories: Int, CaseIterable {
        case avg = 0
        case r = 1
        case hr = 2
        case rbi = 3
        case sb = 4
    }
    
    func getValue(picker: Int) -> String {
        
        switch picker {
        case 1:
            return r
        case 2:
            return hr
        case 3:
            return rbi
        case 4:
            return sb
        default:
            return avg
        }
    }
    
    
}

struct statisticsPitching: Decodable {
    
    var response: [leadersPitching]
    
}

struct leadersPitching: Decodable, Hashable, Identifiable {
    
    var id = UUID()
    
    var name: String
    var team: String
    var team_name: String
    var img: URL
    var thumb: URL
    var era: String
    var w: String
    var so: String
    var sv: String
    var whip: String
    
    enum CodingKeys: String, CodingKey {
        case name, team, team_name, img, thumb, w, era, so, sv, whip
    }
    
    enum pitchingCategories: Int {
        case era = 0
        case w = 1
        case so = 2
        case sv = 3
        case whip = 4
    }
    
    func getValue(picker: Int) -> String {
        
        switch picker {
        case 1:
            return w
        case 2:
            return so
        case 3:
            return sv
        case 4:
            return whip
        default:
            return era
        }
    }
    
}

