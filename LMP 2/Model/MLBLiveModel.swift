//
//  MLBLiveModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 20/07/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct LiveData: Codable {
    
    var gameData: GameData
    
    enum CodingKeys: String, CodingKey {
        case gameData
    }
}

struct GameData: Codable {
    var datatime: DateTime
    var probablePitchers: ProbablePitchers
}

struct DateTime: Codable {
    var time, ampm: String
}

struct ProbablePitchers: Codable {
    var away, home: PitchersData
}

struct PitchersData: Codable {
    var id: Int
    var fullName: String
}
