//
//  statisticsData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 01/06/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct statisticsRegular: Decodable {
    
    var response: [leadersRegular]
    
}

struct leadersRegular: Decodable {
    
    var milb_id: Int
    var name: String
    var team: String
    var team_name: String
    var img: String
    var thumb: String
    var pos: String
    var avg: String
    var r: String
    var hr: String
    var rbi: String
    var sb: String
    var g: String
    var ab: String
    var bb: String
    var ibb: String
    var sf: String
    var sac: String
    var hbp: String
    var h: String
    var h2b: String
    var h3b: String
    var so: String
    var cs: String
    var obp: String
    var slg: String
    var ops: String
        
}


struct statisticsPlayoffs: Decodable {
    
    var response: [leadersPlayoffs]
    
}

struct leadersPlayoffs: Decodable {
    
    var milb_id: Int
    var name: String
    var team: String
    var team_name: String
    var img: String
    var thumb: String
    var pos: String
    var avg: String
    var r: String
    var hr: String
    var rbi: String
    var sb: String
    var g: String
    var ab: String
    var bb: String
    var ibb: String
    var sf: String
    var sac: String
    var hbp: String
    var h: String
    var h2b: String
    var h3b: String
    var so: String
    var cs: String
    var obp: String
    var slg: String
    var ops: String
        
}

