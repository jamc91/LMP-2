//
//  BoxscoreView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 07/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct LinescoreView: View {
    
    let teams: TeamsLinescore
    let linescore: Linescore
    
    var body: some View {
        HStack (alignment: .bottom) {
            TeamNameLinescoreView(
                awayTeamName: teams.away.shortName,
                homeTeamName: teams.home.shortName)
            Spacer()
            ScrollView (linescore.getNumberInnings >= 10 ? .horizontal : .init(),
                        showsIndicators: true) {
                InningsView(totalInnings: 1..<linescore.getNumberInnings + 1, inningsContent: linescore.innings)
            }
            .frame(width: 200, height: 65)
            RHESectionView(teams: linescore.teams)
        }.overlay( Divider().offset(y: -8.0))
    }
}

struct BoxscoreView_Previews: PreviewProvider {
    
    static var previews: some View {
        LinescoreView(
            teams: Constats.shared.live.gameData.teams,
            linescore: Constats.shared.live.liveData.linescore).previewLayout(.sizeThatFits)
    }
}

struct InningsView: View {
    
    var totalInnings: Range<Int>
    var inningsContent: [Inning]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            HStack (spacing: 1) {
                ForEach(totalInnings, id: \.self) { item in
                    Text("\(item)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(width: 20)
                }
            }
            HStack (spacing: 1) {
                ForEach(inningsContent) { inning in
                    VStack (spacing: 0) {
                        LinescoreTextView(value: inning.away.runs)
                        LinescoreTextView(value: inning.home.runs)
                    }
                }
            }
        }
    }
}

struct LinescoreTextView: View {
    
    var value: Int
    
    var body: some View {
        Text("\(value)")
            .font(.caption)
            .fontWeight(value > 0 ? .bold : .none)
            .frame(width: 20)
    }
}
