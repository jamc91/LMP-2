//
//  Status.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Status: Codable {
    let abstractGameState: GameStatus
    let detailedState: String
    let startTimeTBD: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        abstractGameState = try container.decode(forKey: .abstractGameState, default: GameStatus.preview)
        detailedState = try container.decode(forKey: .detailedState, default: "")
        startTimeTBD = try container.decode(forKey: .startTimeTBD, default: false)
    }
    
    init(abstractGameState: GameStatus = .preview, detailedState: String = "", startTimeTBD: Bool = false) {
        self.abstractGameState = abstractGameState
        self.detailedState = detailedState
        self.startTimeTBD = startTimeTBD
    }
}

enum GameStatus: String, Codable, Identifiable {
    case live = "Live", final = "Final", preview = "Preview"
    
    var id: String { rawValue }
}
