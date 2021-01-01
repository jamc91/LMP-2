//
//  BoxscoreModelTest.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/11/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import Combine

enum SelectionTeam: String, CaseIterable, Identifiable {
    case Home, Away
    
    var id: String { rawValue }
    
}

struct BoxscoreResponse: Codable {
    let gameData: GameData
    let liveData: LiveData
    
    init(gameData: GameData = GameData(), liveData: LiveData = LiveData()) {
        self.gameData = gameData
        self.liveData = liveData
    }
}

extension BoxscoreResponse {
    static var data: BoxscoreResponse {
        let path = Bundle.main.path(forResource: "live", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        if let data = try? Data(contentsOf: url),let liveData = try? JSONDecoder().decode(BoxscoreResponse.self, from: data) {
            return liveData
        } else {
            return BoxscoreResponse()
        }
    }
}

struct GameData: Codable {
        let status: Status
        let teams: TeamsLinescore
        let players: [String: Players]
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            status = try container.decode(forKey: .status, default: Status())
            teams = try container.decode(forKey: .teams, default: TeamsLinescore())
            players = try container.decode(forKey: .players, default: [String : Players]())

        }
        
        init(status: Status = Status(), teams: TeamsLinescore = TeamsLinescore(), players: [String: Players] = [String : Players]()) {
            self.status = status
            self.teams = teams
            self.players = players
    }
}

struct LiveData: Codable {
    let linescore: Linescore
    let boxscore: Boxscore
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        linescore = try container.decode(forKey: .linescore, default: Linescore())
        boxscore = try container.decode(forKey: .boxscore, default: Boxscore())
    }
    
    init(linescore: Linescore = Linescore(), boxscore: Boxscore = Boxscore()) {
        self.linescore = linescore
        self.boxscore = boxscore
    }
}
