//
//  CalendarGames.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/12/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct CalendarRow: View {
    
    let game: ScheduleGame
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { proxy in
                HStack {
                    Image("\(game.getTeamID(team: game.awayName))")
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width / 2, height: proxy.size.height / 2.3)
                    Image("\(game.getTeamID(team: game.homeName))")
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width / 2, height: proxy.size.height / 2)
                }
                .frame(maxHeight: .infinity)
                .overlay(alignment: .topLeading) {
                    Text(game.dateStart.dayOfWeekAndTime)
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 5)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        .padding(10)
                }
            }
            .background(TeamBackgroundShape().fill(game.getBackgroundTeam(id: game.getTeamID(team: game.homeName))))
            .background(game.getBackgroundTeam(id: game.getTeamID(team: game.awayName)))
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            Text(game.venue)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            Text("\(game.awayName) at \(game.homeName)")
        }
        .aspectRatio(1.2, contentMode: .fit)
    }
}

struct CalendarGames_Previews: PreviewProvider {
    
    static let mockData: [ScheduleGame] = {
        Constats.shared.calendarGames.response.map { $0.value }.flatMap { $0 }
    }()
    
    static var previews: some View {
        CalendarRow(game: mockData[0])
    }
}
