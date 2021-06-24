//
//  ScoreCellView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 26/12/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScoreLiveCell: View {
    
    let game: Game
    @State private var animation = false
    
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
            Divider()
            if let linescore = game.linescore {
            HStack {
                InningView(arrowStatus: linescore.inningArrowStatus, currentInning: linescore.currentInningOrdinal)
                Spacer()
                DiamondView(baseState: linescore.offense.diamondState)
                Spacer()
                BSOView(
                    balls: linescore.ballsState,
                    strikes: linescore.strikesState,
                    outs: linescore.outsState)
            }
            .padding(.horizontal)
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct ScoreCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ScoreLiveCell(game: Constats.shared.games.dates.first!.games.first!)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .previewLayout(.sizeThatFits)
    }
}
