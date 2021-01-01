//
//  RHESectionView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 18/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct RHESectionView: View {
    
    let topText = ["R", "H", "E"]
    var teams: TeamsLinescoreResults
    
    var body: some View {
        VStack (spacing: 20) {
            HStack (spacing: 1) {
                ForEach(topText, id: \.self) { text in
                    Text(text)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(width: 20, alignment: .center)
                }
            }
            VStack (spacing: 0) {
                TeamRHEInfoView(team: teams.away)
                TeamRHEInfoView(team: teams.home)
            }
        }
        .frame(width: 70, height: 65)
    }
}

struct RHESectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RHESectionView(
                teams: TeamsLinescoreResults(
                    away: InningTeamResults(runs: 0, hits: 0, errors: 0, leftOnBase: 0),
                home: InningTeamResults(runs: 0, hits: 0, errors: 0, leftOnBase: 0))).previewLayout(.sizeThatFits)
            RHESectionView(
                teams: TeamsLinescoreResults(
                    away: InningTeamResults(runs: 0, hits: 0, errors: 0, leftOnBase: 0),
                    home: InningTeamResults(runs: 0, hits: 0, errors: 0, leftOnBase: 0))).previewLayout(.sizeThatFits).preferredColorScheme(.dark)
        }
    }
}

struct TeamRHEInfoView: View {
    
    var team: InningTeamResults
    
    var body: some View {
        HStack (spacing: 2) {
            LinescoreTextView(value: team.runs)
            LinescoreTextView(value: team.hits)
            LinescoreTextView(value: team.errors)
        }
    }
}
