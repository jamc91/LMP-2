//
//  LiveData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct LiveData: Codable {
    let linescore: Linescore
    let boxscore: Boxscore
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        linescore = try container.decode(forKey: .linescore, default: Linescore())
//        boxscore = try container.decode(forKey: .boxscore, default: Boxscore())
//    }
//    
//    init(linescore: Linescore, boxscore: Boxscore) {
//        self.linescore = linescore
//        self.boxscore = boxscore
//    }
}
