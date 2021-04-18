//
//  PlayerView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 10/03/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct PlayerView: View {
    
    var player: Person
    var stats: StatsContent {
        let playerStat = player.stats.first(where: { $0.group.displayName.contains("pitching") && $0.type.displayName.contains("statsSingleSeason")})?.stats ?? StatsContent()
        return playerStat
    }
    
    var body: some View {
        HStack(alignment: .top) {
            player.webImage
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .frame(width: 50, height: 50, alignment: .center)
            VStack(alignment: .leading) {
                Text(player.boxscoreName)
                    .font(.headline)
                Group {
                    Text("\(player.pitchHand.code)HP #\(player.primaryNumber)")
                    Text("\(stats.wins)-\(stats.losses), \(stats.era) ERA")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(player: Constats.shared.games.dates.first!.games.first!.teams.away.probablePitcher).previewLayout(.sizeThatFits)
    }
}
