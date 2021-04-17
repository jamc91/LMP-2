//
//  Venue.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Venue: Codable {
    let id: Int
    let name: String
    let location: Location
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
        name = try container.decode(forKey: .name, default: "")
        location = try container.decode(forKey: .location, default: Location())
    }
    
    init(id: Int = 0, name: String = "", location: Location = Location()) {
        self.id = id
        self.name = name
        self.location = location
    }
}
