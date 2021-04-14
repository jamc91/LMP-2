//
//  ScheduleResponse.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct ScheduleResponse: Codable {
    
    let totalGamesInProgress: Int
    let dates: [Dates]
    
    init() {
        totalGamesInProgress = 0
        dates = [Dates]()
    }
}
