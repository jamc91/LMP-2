//
//  StandingsMLBView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 20/08/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StandingMLBView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        
        VStack {
            ForEach(viewModel.standingMLB.records) { item in
                Section(header: HeaderSectionView(title: item.division?.name ?? "")) {
                    VStack {
                        HeaderStandingMLB()
                        Divider()
                        StandingMLBALView(teamData: item)
                    }
                    .padding(.vertical, 10)
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(10)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct StandingMLBView_Previews: PreviewProvider {
    static var previews: some View {
        StandingMLBView(viewModel: ContentViewModel())
    }
}

struct HeaderStandingMLB: View {
    
    var body: some View {
        HStack {
            Spacer()
            TextStandingMLBView(text: [
                (value: "W", width: 20, fontColor: .secondary),
                (value: "L", width: 20, fontColor: .secondary),
                (value: "PCT", width: 35, fontColor: .secondary),
                (value: "GB", width: 30, fontColor: .secondary),
                (value: "L10", width: 45, fontColor: .secondary),
                (value: "STRK", width: 40, fontColor: .secondary),
                (value: "RDIFF", width: 45, fontColor: .secondary),
            ])
        }
        .padding(.horizontal, 10)
    }
}


struct StandingMLBALView: View {
    
    var teamData: Records
    
    var body: some View {        
        ForEach(teamData.teamRecords) { team in
            HStack {
                Image("\(team.team.id)")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(team.team.abbreviation)
                Spacer()
                TextStandingMLBView(text: [
                    (value: "\(team.wins)", width: 20, fontColor: .primary),
                    (value: "\(team.losses)", width: 20, fontColor: .primary),
                    (value: team.winningPercentage, width: 35, fontColor: .primary),
                    (value: team.gamesBack, width: 30, fontColor: .primary),
                    (value: "\(team.records.splitRecords.first!.wins)-\(team.records.splitRecords.first!.losses)", width: 45, fontColor: .primary),
                    (value: team.streak?.streakCode ?? "", width: 40, fontColor: .primary),
                    (value: "\(team.runDifferential > 0 ? "+" : "")\(team.runDifferential)", width: 45, fontColor: team.runDifferential > 0 ? .green : .red)
                ])
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
        }
    }
}

struct TextStandingMLBView: View {
    
    var text: [(value: String, width: CGFloat, fontColor: Color)]
    
    var body: some View {
        HStack (spacing: 2) {
            Spacer()
            ForEach(text.indices) { idx in
                Text(text[idx].value)
                    .font(.subheadline)
                    .frame(width: text[idx].width)
                    .foregroundColor(text[idx].fontColor)
            }
        }
    }
}
