//
//  DisplayName.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct DisplayName: Codable {
    var displayName: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        displayName = try container.decode(forKey: .displayName, default: "")
    }
    
    init() {
        displayName = ""
    }
}
