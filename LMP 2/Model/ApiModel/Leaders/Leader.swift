//
//  Leader.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 31/12/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct LeadersResponse: Codable {
    let leaders: [Leader]
    
    enum CodingKeys: String, CodingKey {
        case leaders = "response"
    }
}

struct Leader: Identifiable, Codable {
    let mlbid: String
    let name: String
    let img: String
    
    var abbreviate: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        } else {
            return ""
        }
    }
    
    var id: Int {
        Int(mlbid) ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case mlbid = "milb_id"
        case name
        case img
    }
}
