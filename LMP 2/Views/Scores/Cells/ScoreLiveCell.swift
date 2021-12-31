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
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        TeamView(teamName: "\(game.teams.away.team.id)",
                                 wins: game.teams.away.leagueRecord.wins,
                                 losses: game.teams.away.leagueRecord.losses)
                            .frame(width: proxy.size.width / 3)
                        ScoreView(awayScore: game.teams.away.score, homeScore: game.teams.home.score, status: game.status.abstractGameState.rawValue)
                            .frame(width: proxy.size.width / 3)
                        TeamView(teamName: "\(game.teams.home.team.id)",
                                 wins: game.teams.home.leagueRecord.wins,
                                 losses: game.teams.home.leagueRecord.losses)
                            .frame(width: proxy.size.width / 3)
                    }
                    .padding(.vertical, 10)
                    Divider()
                    if let linescore = game.linescore {
                        HStack(spacing: 0) {
                            InningView(arrowStatus: linescore.inningArrowStatus, currentInning: linescore.currentInningOrdinal)
                                .frame(width: proxy.size.width / 3)
                            DiamondView(baseState: linescore.offense.diamondState)
                                .frame(width: proxy.size.width / 3)
                            BSOView(
                                balls: linescore.balls,
                                strikes: linescore.strikes,
                                outs: linescore.outs)
                                .frame(width: proxy.size.width / 3)
                        }
                    }
                }
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            }
            .frame(height: 205)
        }
    }
}

struct ScoreCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ScoreLiveCell(game: Constats.shared.games.dates.first!.games.first!)
        }
        .background(Color(.systemGroupedBackground))
        .previewLayout(.sizeThatFits)
    }
}
