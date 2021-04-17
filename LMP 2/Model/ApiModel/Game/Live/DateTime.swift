//
//  DateTime.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct DateTime: Codable {
    let dateTime: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        dateTime = try container.decode(forKey: .dateTime, default: "")
    }
    
    init() {
        self.dateTime = ""
    }
}
