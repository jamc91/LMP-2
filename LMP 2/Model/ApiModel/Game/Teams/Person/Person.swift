//
//  People.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import SDWebImageSwiftUI

struct Person: Codable {
    let id: Int
    let fullName: String
    let primaryNumber: String
    let boxscoreName: String
    let stats: [Stats]
    let batSide: PrimaryPosition
    let pitchHand: PrimaryPosition
    
    enum CodingKeys: String, CodingKey {
        case id, fullName, primaryNumber, boxscoreName, stats, batSide, pitchHand
    }
    
    var webImage: WebImage {
        return WebImage(url: EndPoint.image(id).urlRequest.url)
    }
    
    var playerPitchingStats: StatsContent {
        let player = stats.first(where: { $0.group.displayName.contains("pitching") && $0.type.displayName.contains("statsSingleSeason")})?.stats ?? StatsContent()
        return player
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
        fullName = try container.decode(forKey: .fullName, default: "")
        primaryNumber = try container.decode(forKey: .primaryNumber, default: "--")
        boxscoreName = try container.decode(forKey: .boxscoreName, default: "unknown")
        stats = try container.decode(forKey: .stats, default: [Stats()])
        batSide = try container.decode(forKey: .batSide, default: PrimaryPosition())
        pitchHand = try container.decode(forKey: .pitchHand, default: PrimaryPosition())
    }
    
    init() {
        id = 0
        fullName = ""
        primaryNumber = "--"
        boxscoreName = "unknown"
        stats = [Stats()]
        batSide = PrimaryPosition()
        pitchHand = PrimaryPosition()
        
    }
}
