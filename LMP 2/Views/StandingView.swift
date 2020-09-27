//
//  StandingView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 21/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StandingView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            ScrollView (showsIndicators: false) {
                VStack (spacing: 10) {
                    TopHeaderView(title: "Standings", showCalendarButton: false).padding(.horizontal, 20)
                    StandingMLBView(viewModel: viewModel)
                }.padding(.bottom, 70)
            }
        }
    }
}


struct StandingView_Previews: PreviewProvider {
    static var previews: some View {
        
        StandingView()
        
    }
}

//MARK: - Standings View

struct StandingLMP2View: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Section(header: HeaderSectionView(title: "First")) {
                StandingRegularSeasonView(standing: viewModel.standingList.first)
            }
            Section(header: HeaderSectionView(title: "Second")) {
                StandingRegularSeasonView(standing: viewModel.standingList.second)
            }
            Section(header: HeaderSectionView(title: "General")) {
                StandingRegularSeasonView(standing: viewModel.standingList.general)
            }
            Section(header: HeaderSectionView(title: "Points")) {
                StandingPointsView(standingPoints: viewModel.standingList.points)
            }
            Section(header: HeaderSectionView(title: "Playoffs")) {
                StandingPlayoffsView(standingPlayoffs: viewModel.standingList.playoffs?.repesca ?? [])
            }
            Section(header: HeaderSectionView(title: "Semi Final")) {
                StandingPlayoffsView(standingPlayoffs: viewModel.standingList.playoffs?.semifinal ?? [])
            }
            Section(header: HeaderSectionView(title: "Final")) {
                StandingPlayoffsView(standingPlayoffs: viewModel.standingList.playoffs?.final ?? [])
            }
        }
        .padding(.horizontal, 20)
    }
}

struct StandingRegularSeasonView: View {
    
    var standing: [StandingRegular]
    
    var body: some View {
        VStack {
            HeaderStandingMLB(items: [("TEAM", .infinity), ("W", 25), ("L", 25), ("PCT", 35), ("GB", 35)])
            ForEach(standing) { item in
                HStack {
                    Image(item.team_name.teamName())
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                    Text(item.team_name)
                        .modifier(modifierText(font: .subheadline))
                    Spacer()
                    Text("\(item.wins)")
                        .modifier(modifierText(frameSize: 25, font: .subheadline))
                    Text("\(item.losses)")
                        .modifier(modifierText(frameSize: 25, font: .subheadline))
                    Text(item.percent)
                        .modifier(modifierText(frameSize: 35, font: .subheadline))
                    Text(item.gb)
                        .modifier(modifierText(frameSize: 35, font: .subheadline))
                    
                }.padding(.horizontal, 10)
                Divider()
            }
        }
        .padding(5)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct StandingPointsView: View {
    
    var standingPoints: [StandingPoints]
    
    var body: some View {
        VStack {
            HeaderStandingMLB(items: [("TEAM", .infinity), ("1V", 30), ("2V", 30), ("TOTAL", 50)])
            ForEach(standingPoints) { item in
                HStack {
                    Image(item.team_name.teamName())
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                    Text(item.team_name)
                        .modifier(modifierText(font: .subheadline))
                    Spacer()
                    Text(item.first)
                        .modifier(modifierText(frameSize: 30, font: .subheadline))
                    Text(item.second)
                        .modifier(modifierText(frameSize: 30, font: .subheadline))
                    Text(item.total)
                        .modifier(modifierText(frameSize: 50, font: .subheadline))
                }.padding(.horizontal, 10)
                Divider()
            }
        }
        .padding(5)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct StandingPlayoffsView: View {
    
    var standingPlayoffs: [StandingPlayoffs]
    
    var body: some View {
        VStack {
            HeaderStandingMLB(items: [("TEAM", .infinity), ("W", 20), ("L", 20), ("PCT", 35), ("GB", 35)])
            ForEach(standingPlayoffs) { item in
                PlayoffsAwayView(team: item)
                PlayoffsHomeView(team: item)
            }
            Divider()
        }
        .padding(5)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct PlayoffsAwayView: View {
    
    var team: StandingPlayoffs
    
    var body: some View {
        HStack {
            Image(team.away_image.teamName())
                .resizable()
                .frame(width: 25, height: 25, alignment: .center)
            Text(team.away_image)
                .modifier(modifierText(font: .subheadline))
            Spacer()
            Text("\(team.away_wins)")
                .modifier(modifierText(frameSize: 20, font: .subheadline))
            Text("\(team.away_losses)")
                .modifier(modifierText(frameSize: 20, font: .subheadline))
            Text(team.away_percent)
                .modifier(modifierText(frameSize: 35, font: .subheadline))
            Text(team.away_games_played)
                .modifier(modifierText(frameSize: 35, font: .subheadline))
        }.padding(.horizontal, 10)
    }
}

struct PlayoffsHomeView: View {
    
    var team: StandingPlayoffs
    
    var body: some View {
        HStack {
            Image(team.home_image.teamName())
                .resizable()
                .frame(width: 25, height: 25, alignment: .center)
            Text(team.home_image)
                .modifier(modifierText(font: .subheadline))
            Spacer()
            Text("\(team.home_wins)")
                .modifier(modifierText(frameSize: 20, font: .subheadline))
            Text("\(team.home_losses)")
                .modifier(modifierText(frameSize: 20, font: .subheadline))
            Text(team.home_percent)
                .modifier(modifierText(frameSize: 35, font: .subheadline))
            Text(team.home_games_played)
                .modifier(modifierText(frameSize: 35, font: .subheadline))
        }.padding(.horizontal, 10)
    }
}

struct modifierText: ViewModifier {
    
    var frameSize : CGFloat?
    var font      : Font = .subheadline
    
    func body(content: Content) -> some View {
        return content
            .font(font)
            .frame(width: frameSize)
            .multilineTextAlignment(.leading)
    }
}

