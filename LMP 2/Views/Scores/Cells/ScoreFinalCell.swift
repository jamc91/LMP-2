//
//  ScoreFinalCell.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/12/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScoreFinalCell: View {
    
    let game: Game
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TeamView(teamName: "\(game.teams.away.team.id)",
                         wins: game.teams.away.leagueRecord.wins,
                         losses: game.teams.away.leagueRecord.losses)
                Spacer()
                ScoreView(awayScore: game.teams.away.score, homeScore: game.teams.home.score, status: game.status.abstractGameState.rawValue)
                Spacer()
                TeamView(teamName: "\(game.teams.home.team.id)",
                         wins: game.teams.home.leagueRecord.wins,
                         losses: game.teams.home.leagueRecord.losses)
            }
            .padding(10)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

struct ScoreFinalCell_Previews: PreviewProvider {
    static var previews: some View {
        ScoreFinalCell(game: Constats.shared.games.dates.first!.games.first!).previewLayout(.sizeThatFits)
    }
}
