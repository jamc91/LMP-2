//
//  People.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct People: Codable {
    var id: Int
    var primaryNumber: String
    var boxscoreName: String
    var stats: [Stats]
    var pitchHand: PrimaryPosition
    
    enum CodingKeys: String, CodingKey {
        case id, primaryNumber, boxscoreName, stats, pitchHand
    }
    
    var webImage: WebImage {
        return WebImage(url: EndPoint.image(id).urlRequest.url?.absoluteString ?? "")
    }
    
    var playerPitchingStats: StatsContent {
        let player = stats.first(where: { $0.group.displayName.contains("pitching") && $0.type.displayName.contains("statsSingleSeason")})?.stats ?? StatsContent()
        return player
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
        primaryNumber = try container.decode(forKey: .primaryNumber, default: "--")
        boxscoreName = try container.decode(forKey: .boxscoreName, default: "unknown")
        stats = try container.decode(forKey: .stats, default: [Stats()])
        pitchHand = try container.decode(forKey: .pitchHand, default: PrimaryPosition())
    }
    
    init() {
        id = 0
        primaryNumber = "--"
        boxscoreName = "unknown"
        stats = [Stats()]
        pitchHand = PrimaryPosition()
        
    }
}
