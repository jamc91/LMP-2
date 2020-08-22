//
//  StandingLMPView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 20/08/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StandingLMPView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            ScrollView {
                Section (header: HeaderSectionView(title: "First")) {
                    StandingLMPFirstView(teamData: viewModel.standingList)
                }
                Section (header: HeaderSectionView(title: "Second")) {
                    StandingLMPSecondView(teamData: viewModel.standingList)
                }
                Section (header: HeaderSectionView(title: "General")) {
                    StandingLMPGeneralView(teamData: viewModel.standingList)
                }
            }
        }
    }
}

struct StandingLMPView_Previews: PreviewProvider {
    static var previews: some View {
        StandingLMPView()
    }
}

struct HeaderStandingLMPRegular: View {
    
    var items: [(column: String,frame: CGFloat)]
    
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                ForEach(items, id: \.column) { item in
                    Text(item.column)
                        .modifier(modifierText(frameSize: item.frame, font: .subheadline))
                    if item.column.contains("Teams") {
                        Spacer()
                    }
                }
            }
            .padding()
            Divider().padding(.horizontal)
        }
    }
}

struct StandingLMPFirstView: View {
    
    var teamData: Standings
    
    var body: some View {
        VStack {
            HeaderStandingLMPRegular(items: [("Teams", .infinity), ("W", 25), ("L", 25), ("PCT", 35), ("DIF", 35)])
            ForEach(teamData.first, id: \.id) { item in
                HStack {
                    Image(item.team_name.teamName())
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text(item.name)
                        .modifier(modifierText(frameSize: .infinity, font: .subheadline))
                    Spacer()
                    Text("\(item.wins)")
                        .modifier(modifierText(frameSize: 25, font: .subheadline))
                    Text("\(item.losses)")
                        .modifier(modifierText(frameSize: 25, font: .subheadline))
                    Text("\(item.percent)")
                        .modifier(modifierText(frameSize: 35, font: .subheadline))
                    Text("\(item.gb)")
                        .modifier(modifierText(frameSize: 35, font: .subheadline))
                }.padding(5)
                Divider().padding(.horizontal)
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct StandingLMPSecondView: View {
    
    var teamData: Standings
    
    var body: some View {
        VStack {
            HeaderStandingLMPRegular(items: [("Teams", .infinity), ("W", 25), ("L", 25), ("PCT", 35), ("DIF", 35)])
            ForEach(teamData.second, id: \.id) { item in
                HStack {
                    Image(item.team_name.teamName())
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text(item.name)
                        .modifier(modifierText(frameSize: .infinity, font: .subheadline))
                    Spacer()
                    Text("\(item.wins)")
                        .modifier(modifierText(frameSize: 25, font: .subheadline))
                    Text("\(item.losses)")
                        .modifier(modifierText(frameSize: 25, font: .subheadline))
                    Text("\(item.percent)")
                        .modifier(modifierText(frameSize: 35, font: .subheadline))
                    Text("\(item.gb)")
                        .modifier(modifierText(frameSize: 35, font: .subheadline))
                }.padding(5)
                Divider().padding(.horizontal)
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct StandingLMPGeneralView: View {
    
    var teamData: Standings
    
    var body: some View {
        VStack {
            HeaderStandingLMPRegular(items: [("Teams", .infinity), ("W", 25), ("L", 25), ("PCT", 35), ("DIF", 35)])
            ForEach(teamData.general, id: \.id) { item in
                HStack {
                    Image(item.team_name.teamName())
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text(item.name)
                        .modifier(modifierText(frameSize: .infinity, font: .subheadline))
                    Spacer()
                    Text("\(item.wins)")
                        .modifier(modifierText(frameSize: 25, font: .subheadline))
                    Text("\(item.losses)")
                        .modifier(modifierText(frameSize: 25, font: .subheadline))
                    Text("\(item.percent)")
                        .modifier(modifierText(frameSize: 35, font: .subheadline))
                    Text("\(item.gb)")
                        .modifier(modifierText(frameSize: 35, font: .subheadline))
                }.padding(5)
                Divider().padding(.horizontal)
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct StandingLMPPointsView: View {
    
    var teamData: Standings
    var width: [CGFloat]
    
    var body: some View {
        HStack {
            ForEach(Array(zip(teamData.points, width)), id: \.0.id) { item in
                Group {
                    Text(item.0.name)
                    Text("\(item.0.first)")
                    Text("\(item.0.second)")
                    Text("\(item.0.total)")
                }.modifier(modifierText(frameSize: item.1, font: .headline))
            }
        }
    }
}
