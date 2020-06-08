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
    var thumb: String
    var pos: String
    var avg: String
    var r: String
    var hr: String
    var rbi: String
    var sb: String

    
    enum CodingKeys: String, CodingKey {
        case name, team, team_name, img, thumb, pos, avg, r, hr, rbi, sb
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
    var thumb: String
    var w: String
    var era: String
    var so: String
    var sv: String
    var whip: String
    
    enum CodingKeys: String, CodingKey {
        case name, team, team_name, img, thumb, w, era, so, sv, whip
    }
}

