//
//  LinescoreView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 16/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct LinescoreView: View {
    
    let response: LiveResponse
    
    var body: some View {
        HStack(alignment: .bottom) {
            teams
            Spacer()
            ScrollView(.horizontal) {
               linescore
            }
            .frame(width: 160)
            .disabled(response.liveData.linescore.getNumberInnings < 10)
            rhe
                .padding(.leading, 20)
        }
        .padding(5)
        .overlay(Divider().offset(y: -8))
    }
}

struct LinescoreView_Previews: PreviewProvider {
    static var previews: some View {
        LinescoreView(response: Constats.shared.live)
    }
}

extension LinescoreView {
    var teams: some View {
        VStack(alignment: .leading) {
            Group {
                Text(response.gameData.teams.away.shortName)
                    .fontWeight(.semibold)
                Text(response.gameData.teams.home.shortName)
                    .fontWeight(.semibold)
            }
            .font(.caption)
        }
    }
    
    var linescore: some View {
        HStack(alignment: .top, spacing: 10) {
            ForEach(0..<response.liveData.linescore.getNumberInnings) { inning in
                VStack {
                    Text("\(inning+1)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 1)
                    if inning < response.liveData.linescore.innings.count {
                        TextLinescore(text: response.liveData.linescore.innings[inning].away.runs)
                        TextLinescore(text: response.liveData.linescore.innings[inning].home.runs)
                    }
                }
            }
        }
    }
    
    var rhe: some View {
        HStack {
            RHEText(
                headerText: "R",
                away: response.liveData.linescore.teams.away?.runs,
                home: response.liveData.linescore.teams.home?.runs)
            RHEText(
                headerText: "H",
                away: response.liveData.linescore.teams.away?.hits,
                home: response.liveData.linescore.teams.home?.hits)
            RHEText(
                headerText: "E",
                away: response.liveData.linescore.teams.away?.errors,
                home: response.liveData.linescore.teams.home?.errors)
        }
    }
}

