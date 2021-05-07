//
//  DetailPreview.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct DetailPreview: View {
    
    let previewData: LiveResponse
    let game: Game
    
    var body: some View {
        List {
            Group {
                ScorePreviewCell(game: game, venue: previewData.gameData.venue)
            }.listRowInsets(EdgeInsets())
            VStack(alignment: .leading, spacing: 10) {
                Text("LINEUPS")
                    .font(.subheadline)
                Text(previewData.gameData.teams.away.name)
                    .font(.headline)
            }
            .foregroundColor(.secondary)
            LineupView(liveData: previewData, team: previewData.liveData.boxscore.teams.away)
            VStack(alignment: .leading) {
                Text(previewData.gameData.teams.home.name)
                    .font(.headline)
            }
            .foregroundColor(.secondary)
            LineupView(liveData: previewData, team: previewData.liveData.boxscore.teams.home)
        }
    }
    private func getPlayerInfo(id: Int) -> Person {
        previewData.gameData.players["ID\(id)", default: Person()]
    }
}

struct DetailPreview_Previews: PreviewProvider {
    static var previews: some View {
        DetailPreview(previewData: Constats.shared.live, game: Constats.shared.games.dates[0].games[0])
            .previewLayout(.sizeThatFits)
    }
}

struct LineupView: View {
    
    let liveData: LiveResponse
    let team: BoxscoreTeamsContent
    
    var body: some View {
        Section(header: header) {
            if team.battingOrder.isEmpty {
                Text("LINEUP CURRENTLY UNAVAILABLE")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                ForEach(team.battingOrder, id: \.self) { id in
                    let batter = getPlayerInfo(id: id)
                    let position = team.players["ID\(id)"]!.position.abbreviation
                    HStack {
                        Text(batter.fullName)
                            .fontWeight(.semibold)
                        Spacer()
                        Text(position)
                            .frame(width: 60)
                    }
                    .font(.subheadline)
                }
            }
        }
    }
    private func getPlayerInfo(id: Int) -> Person {
        liveData.gameData.players["ID\(id)", default: Person()]
    }
    
    var header: some View {
        HStack {
            Text("Player").font(.caption).foregroundColor(.secondary)
            Spacer()
            Text("Position").font(.caption).foregroundColor(.secondary)
        }
    }
}
