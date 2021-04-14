//
//  Dates.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Dates: Identifiable, Codable {
    
    var id = UUID()
    let games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case games
    }
}
