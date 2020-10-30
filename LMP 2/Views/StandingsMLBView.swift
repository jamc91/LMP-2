//
//  StandingsMLBView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 20/08/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StandingMLBView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        
        VStack {
            ForEach(viewModel.standingMLB.records) { item in
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
        StandingMLBView(viewModel: ViewModel())
    }
}

struct HeaderStandingMLB: View {
    
    var items: [(column: String,frame: CGFloat)]
    
    var body: some View {
        
        VStack {
            HStack {
                ForEach(items, id: \.column) { item in
                    Text(item.column)
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
                    
                Spacer()
                Text("\(team.wins)")
                    
                Text("\(team.losses)")
                    
                Text(team.winningPercentage)
                    
                Text(team.gamesBack)
                    
                Text("\(team.records.splitRecords.first!.wins)-\(team.records.splitRecords.first!.losses)")
                    
                Text(team.streak?.streakCode ?? "")
                   
                Text("\(team.runDifferential > 0 ? "+" : "")\(team.runDifferential)")
                   
                    .foregroundColor(team.runDifferential > 0 ? .green : .red)
            }
            .padding(5)
        }
    }
}
