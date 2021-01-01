//
//  ScorePreviewCell.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/12/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScorePreviewCell: View {
    
    let game: Games
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TeamView(teamName: "\(game.teams.away.team.id)",
                         wins: game.teams.away.leagueRecord.wins,
                         losses: game.teams.away.leagueRecord.losses)
                Spacer()
                VStack {
                    Text("@")
                        .font(.system(size: 50, weight: .semibold, design: .rounded))
                        .foregroundColor(.secondary)
                    Text(game.gameDate.hourFormat(status: game.status.startTimeTBD))
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                TeamView(teamName: "\(game.teams.home.team.id)",
                         wins: game.teams.home.leagueRecord.wins,
                         losses: game.teams.home.leagueRecord.losses)
            }
            .padding()
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
            ScorePreviewCell(game: Games.data[0])
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .previewLayout(.sizeThatFits)
    }
}
