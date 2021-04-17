//
//  Location.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Location: Codable {
    let city: String
    let state: String
    let stateAbbrev: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        city = try container.decode(forKey: .city, default: "")
        state = try container.decode(forKey: .state, default: "")
        stateAbbrev = try container.decode(forKey: .stateAbbrev, default: "")
    }
    
    init() {
        city = ""
        state = ""
        stateAbbrev = ""
    }
}
