//
//  StandingsMLBView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 20/08/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StandingMLBView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        
        VStack {
            ForEach(viewModel.standingMLBALList.records) { item in
                Section(header: HeaderSectionView(title: item.division?.name ?? "")) {
                    VStack {
                        HeaderStandingMLB(items: [("TEAM", .infinity), ("W", 20), ("L", 20), ("PCT", 35), ("GB", 30), ("L10", 40), ("STRK", 40), ("RDIFF", 45)])
                        StandingMLBALView(teamData: item)
                    }
                    .padding(5)
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(10)
                }
            }
        }
        .padding(.horizontal, 20)
        .background(Color(.systemGroupedBackground))
    }
}

struct StandingMLBView_Previews: PreviewProvider {
    static var previews: some View {
        StandingMLBView()
    }
}

struct HeaderStandingMLB: View {
    
    var items: [(column: String,frame: CGFloat)]
    
    var body: some View {
        
        VStack (spacing: 0) {
            HStack {
                ForEach(items, id: \.column) { item in
                    Text(item.column)
                        .modifier(modifierText(frameSize: item.frame, font: .subheadline))
                        .foregroundColor(.secondary)
                    if item.column.contains("TEAM")  {
                        Spacer()
                    }
                }
            }
            .padding(5)
            Divider().padding(.horizontal, 5)
        }
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
                    .modifier(modifierText(frameSize: .infinity, font: .subheadline))
                Spacer()
                Text("\(team.wins)")
                    .modifier(modifierText(frameSize: 20, font: .subheadline))
                Text("\(team.losses)")
                    .modifier(modifierText(frameSize: 20, font: .subheadline))
                Text(team.winningPercentage)
                    .modifier(modifierText(frameSize: 35, font: .subheadline))
                Text(team.gamesBack)
                    .modifier(modifierText(frameSize: 30, font: .subheadline))
                Text("\(team.records.splitRecords.first!.wins)-\(team.records.splitRecords.first!.losses)")
                    .modifier(modifierText(frameSize: 40, font: .subheadline))
                Text(team.streak?.streakCode ?? "")
                    .modifier(modifierText(frameSize: 40, font: .subheadline))
                Text("\(team.runDifferential > 0 ? "+" : "")\(team.runDifferential)")
                    .modifier(modifierText(frameSize: 45, font: .subheadline))
                    .foregroundColor(team.runDifferential > 0 ? .green : .red)
            }
            .padding(5)
        }
    }
}
