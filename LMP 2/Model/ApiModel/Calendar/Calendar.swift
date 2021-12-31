//
//  Calendar.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 25/12/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import SwiftUI

struct CalendarResponse: Codable {
    let response: [String: [ScheduleGame]]
}

struct ScheduleGame: Codable, Identifiable {
    let id: Int
    let homeName: String
    let awayName: String
    let venue: String
    let dateStart: Date
    
    func getTeamID(team: String) -> Int {
        switch team {
        case "Mayos de Navojoa":
            return 676
        case "Tomateros de Culiacán":
            return 678
        case "Águilas de Mexicali":
            return 673
        case "Charros de Jalisco":
            return 674
        case "Yaquis de Obregón":
            return 680
        case "Algodoneros de Guasave":
            return 5482
        case "Sultanes de Monterrey":
            return 5483
        case "Naranjeros de Hermosillo":
            return 677
        default:
            return 0
        }
    }
    
    func getBackgroundTeam(id: Int) -> Color {
        switch id {
        case 680:
            return Color("blue")
        case 5482:
            return Color("brown")
        case 5483:
            return Color("darkBlue")
        case 677:
            return Color("Orange")
        case 678:
            return Color("cayenne")
        case 676:
            return Color("red")
        case 673:
            return Color("red")
        case 674:
            return Color("blue")
        default:
            return Color.white
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "mlbid"
        case homeName
        case awayName
        case venue
        case dateStart
    }
}
