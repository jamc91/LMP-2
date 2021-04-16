//
//  TeamContent.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct TeamContent: Codable {
    let leagueRecord: LeagueRecord
    let score: Int
    let team: TeamInformation
    let probablePitcher: Person
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        leagueRecord = try container.decode(forKey: .leagueRecord, default: LeagueRecord())
        score = try container.decode(forKey: .score, default: 0)
        team = try container.decode(forKey: .team, default: TeamInformation())
        probablePitcher = try container.decode(forKey: .probablePitcher, default: Person())
        
    }
    
    init(leagueRecord: LeagueRecord = LeagueRecord(), score: Int = 0, team: TeamInformation = TeamInformation(), probablePitcher: Person = Person()) {
        self.leagueRecord = leagueRecord
        self.score = score
        self.team = team
        self.probablePitcher = probablePitcher
    }
}
