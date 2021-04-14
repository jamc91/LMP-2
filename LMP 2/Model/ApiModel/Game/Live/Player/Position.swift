//
//  Position.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Position: Codable {
    let abbreviation: String
    let type: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        abbreviation = try container.decode(forKey: .abbreviation, default: "")
        type = try container.decode(forKey: .type, default: "")
    }
    
    init(abbreviation: String = "", type: String = "") {
        self.abbreviation = abbreviation
        self.type = type
    }
}
