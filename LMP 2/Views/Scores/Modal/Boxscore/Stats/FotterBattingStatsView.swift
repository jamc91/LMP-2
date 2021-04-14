//
//  FotterBattingStatsView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 13/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct FotterBattingStatsView: View {
    
    var team: BoxscoreTeamsContent
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                VStack (alignment: .leading) {
                    ForEach(team.note) { note in
                        TextInfoView(label: note.label, value: note.value)
                    }
                }
                .padding(.bottom)
                ForEach(team.info) { teamInfo in
                    Text(teamInfo.title)
                        .font(.caption)
                        .bold()
                    ForEach(teamInfo.fieldList) { item in
                        TextInfoView(label: item.label, value: item.value)
                    }
                }
            }
            Spacer()
        }
        .padding(5)
    }
}

struct FotterBattingStatsView_Previews: PreviewProvider {
    static var previews: some View {
        FotterBattingStatsView(team: Constats.shared.live.liveData.boxscore.teams.away).previewLayout(.sizeThatFits)
    }
}
