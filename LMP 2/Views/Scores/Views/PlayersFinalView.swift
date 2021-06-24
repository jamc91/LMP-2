//
//  PlayersFinalView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 31/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct PlayersFinalView: View {
    
    let decisions: Decisions
    @State private var selectionItem: DecisionsPlayers = .winner
    
    var body: some View {
        VStack(spacing: 0) {
                TabView(selection: $selectionItem) {
                    ForEach(DecisionsPlayers.allCases, id: \.self) { player in
                        getPlayer(player: player)
                            .tag(player)
                            
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                HStack {
                    ForEach(DecisionsPlayers.allCases, id: \.self) { player in
                        Circle()
                            .fill(selectionItem == player ? Color.primary : Color.secondary)
                            .frame(width: 8, height: 8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
                .padding(.bottom, 10)
            }
            .frame(height: 100)
        
        
    }
    @ViewBuilder func getPlayer(player: DecisionsPlayers) -> some View {
        switch player {
        case .winner:
            DecisionsPlayerView(title: player.rawValue.capitalized, player: decisions.winner)
        case .loser:
            DecisionsPlayerView(title: player.rawValue.capitalized, player: decisions.loser)
        case .save:
            DecisionsPlayerView(title: player.rawValue.capitalized, player: decisions.save)
        }
    }
}

struct PlayersFinalView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersFinalView(decisions: Constats.shared.games.dates.first!.games.first!.decisions)
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}

enum DecisionsPlayers: String, CaseIterable {
    case winner
    case loser
    case save
}

struct DecisionsPlayerView: View {
    
    var title: String
    var player: Person
    var stats: StatsContent {
        let playerStat = player.stats.first(where: { $0.group.displayName.contains("pitching") && $0.type.displayName.contains("statsSingleSeason")})?.stats ?? StatsContent()
        return playerStat
    }
    
    var body: some View {
        HStack {
            player.webImage
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .frame(width: 50, height: 50, alignment: .center)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(player.fullName)
                    .font(.headline)
                Group {
                    Text("\(player.pitchHand.code)HP #\(player.primaryNumber)")
                    Text("\(stats.wins)-\(stats.losses), \(stats.era) ERA")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(10)
    }
}
