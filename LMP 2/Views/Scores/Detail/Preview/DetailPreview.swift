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
    
    var body: some View {
        List {
            Group {
            HStack {
                TeamView(
                    teamName: "\(previewData.gameData.teams.away.id)",
                    wins: previewData.gameData.teams.away.record.wins,
                    losses: previewData.gameData.teams.away.record.losses)
                    .scaleEffect(0.7)
                Spacer()
                VStack(spacing: 5) {
                    Text(previewData.gameData.teams.away.teamName)
                        .fontWeight(.semibold) +
                    Text(" @ ")
                        .foregroundColor(.secondary) +
                    Text(previewData.gameData.teams.home.teamName)
                        .fontWeight(.semibold)
                    Group {
                        Label(previewData.gameData.datetime.dateTime.hourFormat(), systemImage: "clock")
                        Text("\(previewData.gameData.venue.name)•\(previewData.gameData.venue.location.city), \(previewData.gameData.venue.location.stateAbbrev)")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                }
                Spacer()
                TeamView(
                    teamName: "\(previewData.gameData.teams.home.id)",
                    wins: previewData.gameData.teams.home.record.wins,
                    losses: previewData.gameData.teams.home.record.losses)
                    .scaleEffect(0.7)
            }
            ProbablePitcherView(player1: getPlayerInfo(id: previewData.gameData.probablePitchers?.away.id ?? 0), player2: getPlayerInfo(id: previewData.gameData.probablePitchers?.home.id ?? 0))
            }.listRowInsets(EdgeInsets())
            VStack(alignment: .leading, spacing: 10) {
                Text("LINEUPS")
                Text(previewData.gameData.teams.away.name)
                    .font(.headline)
            }
            .foregroundColor(.secondary)
            Section(header: HStack { Text("Player").font(.caption).foregroundColor(.secondary)
                        Spacer()
                        Text("Position").font(.caption).foregroundColor(.secondary)}) {
                ForEach(previewData.liveData.boxscore.teams.away.battingOrder, id: \.self) { id in
                    let batter = getPlayerInfo(id: id)
                    let position = previewData.liveData.boxscore.teams.away.players["ID\(id)"]!.position.abbreviation
                    HStack {
                        Text(batter.fullName)
                            .fontWeight(.semibold)
                        Spacer()
                        Text(position)
                    }
                    .font(.subheadline)
                }
            }
            HStack {
                
            }
            .listRowBackground(Color(.systemGray5))
            VStack(alignment: .leading) {
                Text(previewData.gameData.teams.home.name)
                    .font(.headline)
            }
            .foregroundColor(.secondary)
            Section(header: HStack { Text("Player").font(.caption).foregroundColor(.secondary)
                        Spacer()
                        Text("Position").font(.caption).foregroundColor(.secondary)}) {
                ForEach(previewData.liveData.boxscore.teams.home.battingOrder, id: \.self) { id in
                    let batter = getPlayerInfo(id: id)
                    let position = previewData.liveData.boxscore.teams.home.players["ID\(id)"]!.position.abbreviation
                    HStack {
                        Text(batter.fullName)
                            .fontWeight(.semibold)
                        Spacer()
                        Text(position)
                            
                    }
                    .font(.subheadline)
                }
            }
        }
    }
    private func getPlayerInfo(id: Int) -> Person {
        previewData.gameData.players["ID\(id)", default: Person()]
    }
}

struct DetailPreview_Previews: PreviewProvider {
    static var previews: some View {
        DetailPreview(previewData: Constats.shared.live)
            .previewLayout(.sizeThatFits)
    }
}
