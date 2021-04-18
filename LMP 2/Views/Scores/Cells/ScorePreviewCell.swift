//
//  ScorePreviewCell.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/12/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScorePreviewCell: View {
    
    let game: Game
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TeamView(teamName: "\(game.teams.away.team.id)",
                         wins: game.teams.away.leagueRecord.wins,
                         losses: game.teams.away.leagueRecord.losses)
                Spacer()
                VStack(spacing: 10) {
                    Group {
                        Text(game.teams.away.team.teamName)
                            .fontWeight(.semibold) +
                            Text(" @ ")
                            .foregroundColor(.secondary) +
                            Text(game.teams.home.team.teamName)
                            .fontWeight(.semibold)
                    }
                    .minimumScaleFactor(0.2)
                    .lineLimit(1)
                    Label(game.gameDate.hourFormat(status: game.status.startTimeTBD), systemImage: "clock")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                TeamView(teamName: "\(game.teams.home.team.id)",
                         wins: game.teams.home.leagueRecord.wins,
                         losses: game.teams.home.leagueRecord.losses)
            }
            .padding(10)
            Divider()
            ProbablePitcherView(player1: game.teams.away.probablePitcher, player2: game.teams.home.probablePitcher)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct ScorePreviewCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ScorePreviewCell(game: Constats.shared.games.dates.first!.games.first!)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .previewLayout(.sizeThatFits)
    }
}
