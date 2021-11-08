//
//  MLBApiEndpoints.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/07/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct MLBApiEndpoints {
    static let baseURL = "https://statsapi.mlb.com/api/"

    enum Section: String {
        case schedule
        case game
        case live
        case standings
        case feed
        case content
    }
    
    enum Version: String {
        case first = "v1"
        case second = "v1.1"
    }
}
