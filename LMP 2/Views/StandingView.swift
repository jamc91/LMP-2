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
    @State private var showingActionSheet = false
    @State private var season: Standings.SeasonState = .regular
    @State private var standingValue: Standings.StandingState = .first
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            ScrollView (showsIndicators: false) {
                VStack (spacing: 10) {
                    TopHeaderView(title: "Standings", showButton: false).padding(.horizontal, 20)
                    StandingMLBView(viewModel: viewModel)
                        .padding(.horizontal)
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

struct TopView: View {
    
    @Binding var seasonState: Standings.SeasonState
    @Binding var pickerState: Standings.StandingState
    @Binding var showingActionSheet: Bool
    
    var body: some View {
        
        VStack {
            Button(action: {
                self.showingActionSheet = true
            }) {
                HStack {
                    Text(seasonState.rawValue.capitalized)
                    Image(systemName: "chevron.down")
                }.foregroundColor(Color(.systemBlue))
                    .padding(3)
            }.buttonStyle(PlainButtonStyle())
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text(""), buttons: [
                        .default(Text("Regular")){
                            self.seasonState = .regular
                            self.pickerState = .first
                        },
                        .default(Text("Playoffs")){
                            self.seasonState = .playoffs
                            self.pickerState = .playoffs
                        },
                        .cancel()])
            }
        
        Picker(selection: $pickerState, label: Text("")) {
            if self.seasonState == .regular {
                Text("1ra Vuelta").tag(Standings.StandingState.first)
                Text("2da Vuelta").tag(Standings.StandingState.second)
                Text("General").tag(Standings.StandingState.general)
                Text("Puntos").tag(Standings.StandingState.points)
            }
            else {
                Text("Playoffs").tag(Standings.StandingState.playoffs)
                Text("Semifinal").tag(Standings.StandingState.semifinal)
                Text("Final").tag(Standings.StandingState.final)
            }
        }.pickerStyle(SegmentedPickerStyle())
         .padding(.bottom)
         .animation(nil)
        }
    }
}

struct StandingRegularView: View {
    
    var standing: StandingRegular
    
    var body: some View {
        VStack {
            HStack (spacing: 5) {
                Image(standing.team_name.teamName())
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                Text(standing.name)
                    .modifier(modifierText(font: .subheadline))
                Spacer()
                Text("\(standing.wins)")
                    .modifier(modifierText(frameSize: 25, font: .subheadline))
                Text("\(standing.losses)")
                    .modifier(modifierText(frameSize: 25, font: .subheadline))
                Text(standing.percent)
                    .modifier(modifierText(frameSize: 35, font: .subheadline))
                Text(standing.gb)
                    .modifier(modifierText(frameSize: 35, font: .subheadline))
                
            }
            Divider()
        }
    }
}

struct StandingPointsView: View {
    
    var standingPoints: StandingPoints
    
    var body: some View {
        VStack {
            HStack (spacing: 5) {
                Image(standingPoints.team_name.teamName())
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                Text(standingPoints.name)
                    .modifier(modifierText(font: .subheadline))
                Spacer()
                Text(standingPoints.first)
                    .modifier(modifierText(frameSize: 30, font: .subheadline))
                Text(standingPoints.second)
                    .modifier(modifierText(frameSize: 30, font: .subheadline))
                Text(standingPoints.total)
                    .modifier(modifierText(frameSize: 40, font: .subheadline))
            }
            Divider()
        }
    }
}

struct StandingPlayoffsView: View {
    
    var standingPlayoffs: StandingPlayoffs
    
    var body: some View {
        VStack {
            HStack (spacing: 5) {
                Image(standingPlayoffs.away_image.teamName())
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                Text(standingPlayoffs.away_team_name)
                    .modifier(modifierText(font: .subheadline))
                Spacer()
                Text("\(standingPlayoffs.away_wins)")
                    .modifier(modifierText(frameSize: 20, font: .subheadline))
                Text("\(standingPlayoffs.away_losses)")
                    .modifier(modifierText(frameSize: 20, font: .subheadline))
                Text(standingPlayoffs.away_percent)
                    .modifier(modifierText(frameSize: 35, font: .subheadline))
                Text(standingPlayoffs.away_games_played)
                    .modifier(modifierText(frameSize: 35, font: .subheadline))
            }
            HStack (spacing: 5) {
                Image(standingPlayoffs.home_image.teamName())
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                Text(standingPlayoffs.home_team_name)
                    .modifier(modifierText(font: .subheadline))
                Spacer()
                Text("\(standingPlayoffs.home_wins)")
                    .modifier(modifierText(frameSize: 20, font: .subheadline))
                Text("\(standingPlayoffs.home_losses)")
                    .modifier(modifierText(frameSize: 20, font: .subheadline))
                Text(standingPlayoffs.home_percent)
                    .modifier(modifierText(frameSize: 35, font: .subheadline))
                Text(standingPlayoffs.home_games_played)
                    .modifier(modifierText(frameSize: 35, font: .subheadline))
            }
            Divider()
        }
    }
}

struct HeaderRegularView: View {
    
    var body: some View {
        
        HStack (spacing: 5){
            Text("Equipos")
                .font(.subheadline)
            Spacer()
            Text("G")
                .modifier(modifierText(frameSize: 25))
            Text("P")
                .modifier(modifierText(frameSize: 25))
            Text("PCT")
                .modifier(modifierText(frameSize: 35))
            Text("DIF")
                .modifier(modifierText(frameSize: 35))
        }
    }
}

struct HeaderPointsView: View {
    
    var body: some View {
        
        HStack (spacing: 5){
            Text("Equipos")
                .font(.subheadline)
            Spacer()
            Text("1A")
                .modifier(modifierText(frameSize: 30))
            Text("2A")
                .modifier(modifierText(frameSize: 30))
            Text("Total")
                .modifier(modifierText(frameSize: 40))
        }
    }
}

struct HeaderPlayoffsView: View {
    
    var body: some View {
        
        HStack (spacing: 5){
            Text("Equipos")
                .font(.subheadline)
            Spacer()
            Text("G")
                .modifier(modifierText(frameSize: 20, font: .subheadline))
            Text("P")
                .modifier(modifierText(frameSize: 20, font: .subheadline))
            Text("PCT")
                .modifier(modifierText(frameSize: 35, font: .subheadline))
            Text("JV")
                .modifier(modifierText(frameSize: 35, font: .subheadline))
        }
    }
}

struct modifierText: ViewModifier {
    
    @State var frameSize : CGFloat?
    @State var font      : Font = .subheadline
    
    func body(content: Content) -> some View {
        return content
            .font(font)
            .frame(width: frameSize)
            .multilineTextAlignment(.leading)
    }
}

