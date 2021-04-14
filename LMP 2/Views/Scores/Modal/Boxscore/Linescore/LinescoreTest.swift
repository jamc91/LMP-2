//
//  LinescoreTest.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 10/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct LinescoreTest: View {
    
    let content: LiveResponse
    
    var body: some View {
        HStack(alignment: .bottom) {
            teamNames
            Spacer()
            linescore
            Spacer()
            sectionRHE
        }
        .overlay(
            Divider().offset(y: -10.0)
        )
    }
}

struct LinescoreTest_Previews: PreviewProvider {
    static var previews: some View {
        LinescoreTest(content: Constats.shared.live).previewLayout(.sizeThatFits)
    }
}

extension LinescoreTest {
    var teamNames: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(content.gameData.teams.away.shortName).bold()
            Text(content.gameData.teams.home.shortName).bold()
        }
        .font(.caption)
    }
    
    var linescore: some View {
        
        ScrollView(content.liveData.linescore.getNumberInnings >= 10 ? .horizontal : .init(), showsIndicators: true) {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 1) {
                    ForEach(1..<content.liveData.linescore.getNumberInnings+1) { inning in
                        Text(String(inning))
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(width: 20)
                    }
                }
                HStack(spacing: 1) {
                    ForEach(content.liveData.linescore.innings) { inning in
                        TextLinescore(
                            value: nil, away: inning.away.runs,
                            home: inning.home.runs)
                    }
                }
            }.frame(alignment: .bottom)
        }
        .frame(width: 190, height: 50, alignment: .bottom)
    }
    
    var sectionRHE: some View {
        HStack(spacing: 1) {
            TextLinescore(
                value: "R", away: content.liveData.linescore.teams.away.runs,
                home: content.liveData.linescore.teams.home.runs)
            TextLinescore(
                value: "H", away: content.liveData.linescore.teams.away.hits,
                home: content.liveData.linescore.teams.home.hits)
            TextLinescore(
                value: "E", away: content.liveData.linescore.teams.away.errors,
                home: content.liveData.linescore.teams.home.errors)
        }
    }
}
