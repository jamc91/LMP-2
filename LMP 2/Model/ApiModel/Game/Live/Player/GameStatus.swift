//
//  GameStatus.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct PlayerStatus: Codable {
    
    let isCurrentBatter, isCurrentPitcher, isOnBench, isSubstitute: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        isCurrentBatter = try container.decode(forKey: .isCurrentBatter, default: false)
        isCurrentPitcher = try container.decode(forKey: .isCurrentPitcher, default: false)
        isOnBench = try container.decode(forKey: .isOnBench, default: false)
        isSubstitute = try container.decode(forKey: .isSubstitute, default: false)
    }
    
    init(isCurrentBatter: Bool = false, isCurrentPitcher: Bool = false, isOnBench: Bool = false, isSubstitute: Bool = false) {
        self.isCurrentBatter = isCurrentBatter
        self.isCurrentPitcher = isCurrentPitcher
        self.isOnBench = isOnBench
        self.isSubstitute = isSubstitute
    }
}
