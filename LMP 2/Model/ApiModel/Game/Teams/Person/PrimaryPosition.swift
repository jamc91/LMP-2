//
//  Position.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct PrimaryPosition: Codable {
    var code, description, abbreviation: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try container.decode(forKey: .code, default: "")
        description = try container.decode(forKey: .description, default: "")
        abbreviation = try container.decode(forKey: .abbreviation, default: "")
    }
    
    init() {
        self.code = "?"
        self.description = "????"
        self.abbreviation = ""
    }
}
