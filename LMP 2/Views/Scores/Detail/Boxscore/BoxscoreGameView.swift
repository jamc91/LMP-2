//
//  BoxscoreGameView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 10/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct BoxscoreGameView: View {
    
    var live: LiveResponse
    @State private var selectionTeam: SelectionTeam = .home
    
    var body: some View {
        List {
            Group {
                LinescoreView(response: live)
                picker
                BattingStatsView(content: live, selectedTeam: selectionTeam)
                PitchingStatsView(content: live, selectedTeam: selectionTeam)
                FooterPitchingStatsView(note: live.liveData.boxscore.info)
            }
            .listRowInsets(EdgeInsets())
        }
    }
}

struct BoxscoreGameView_Previews: PreviewProvider {
    static var previews: some View {
        BoxscoreGameView(live: Constats.shared.live)
    }
}

extension BoxscoreGameView {
    var picker: some View {
        Picker("", selection: $selectionTeam) {
            Text(live.gameData.teams.away.teamName).tag(SelectionTeam.away)
            Text(live.gameData.teams.home.teamName).tag(SelectionTeam.home)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(10)
    }
}
