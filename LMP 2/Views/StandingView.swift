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
    @State private var buttonState = "Regular"
    @State private var bottomPickerValue = 0
    @State private var showActionSheet = false
    
    var body: some View {
        VStack (alignment: .center) {
            Button(action: {
                self.showActionSheet = true
            }) {
                HStack {
                    Text(buttonState)
                    Image(systemName: "chevron.down")
                }.foregroundColor(Color(.systemBlue))
                 .padding(3)
            }.buttonStyle(PlainButtonStyle())
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text(""), buttons: [
                        .default(Text("Regular")){
                            self.buttonState = "Regular"
                            self.bottomPickerValue = 0
                        },
                        .default(Text("Playoffs")){
                            self.buttonState = "Playoffs"
                            self.bottomPickerValue = 0
                        },
                        .cancel()])
            }
            Picker(selection: $bottomPickerValue, label: Text("")) {
                if self.buttonState == "Regular" {
                    Text("1ra Vuelta").tag(0)
                    Text("2da Vuelta").tag(1)
                    Text("General").tag(2)
                    Text("Puntos").tag(3)
                }
                else
                {
                    Text("Playoffs").tag(0)
                    Text("Semifinal").tag(1)
                    Text("Final").tag(2)
                }
            }.pickerStyle(SegmentedPickerStyle())
             .padding(.bottom)
             .animation(nil)
            VStack {
                showHeaderView(bottom: self.bottomPickerValue, type: self.buttonState)
                Divider()
                standingType(type: bottomPickerValue, buttonValue: buttonState)
                   
            }.animation(nil)
               
            
        }
        .frame(minHeight: 150, maxHeight: 549, alignment: .top)
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
    
   func standingType(type: Int, buttonValue: String) -> some View {
        
        if buttonValue == "Regular" {
            switch type {
            case 0:
                return ForEach(self.viewModel.standingList.first, id: \.id) { item in
                    StandingRegularView(standing: item)
                }
                .eraseToAnyView()
                
            case 1:
                return ForEach(self.viewModel.standingList.second, id: \.id) { item in
                    StandingRegularView(standing: item)
                }
                .eraseToAnyView()
            case 2:
                return ForEach(self.viewModel.standingList.general, id: \.id) { item in
                    StandingRegularView(standing: item)
                }
                .eraseToAnyView()
            case 3:
                return ForEach(self.viewModel.standingList.points, id: \.id) { item in
                    StandingPointsView(standingPoints: item)
                }
                    .eraseToAnyView()
            default:
                return ForEach(self.viewModel.standingList.first, id: \.id) { item in
                    StandingRegularView(standing: item)
                }
                .eraseToAnyView()
            }
        }
        else {
            
            switch type {

            case 1:
                return ForEach(self.viewModel.standingList.playoffs!.semifinal, id: \.away_team_name) { item in
                    StandingPlayoffsView(standingPlayoffs: item)
                    
                }
                .eraseToAnyView()
            case 2:
                return ForEach(self.viewModel.standingList.playoffs!.final, id: \.away_team_name) { item in
                    StandingPlayoffsView(standingPlayoffs: item)
                    
                }
                .eraseToAnyView()
            default:
                return ForEach(self.viewModel.standingList.playoffs!.repesca, id: \.away_team_name) { item in
                    StandingPlayoffsView(standingPlayoffs: item)
                    
                }
                .eraseToAnyView()
            }
        }
    }
}

struct StandingView_Previews: PreviewProvider {
    static var previews: some View {

            StandingView()
            
    }
}

struct StandingRegularView: View {
    
    var standing: First
        
    var body: some View {
        
        VStack {
            HStack (spacing: 5) {
                Image(standing.team_name)
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
    
    var standingPoints: Points
    
    var body: some View {
        VStack {
            HStack (spacing: 5) {
                Image(standingPoints.team_name)
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
    
    var standingPlayoffs: Repesca
    
    var body: some View {
        VStack {
            HStack (spacing: 5) {
                Image(standingPlayoffs.away_image)
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
                Image(standingPlayoffs.home_image)
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

func showHeaderView(bottom: Int, type: String) -> some View {
    if type == "Regular" {
        switch bottom {
        case 3:
            return HStack (spacing: 5) {
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
            .eraseToAnyView()
        default:
            return HStack (spacing: 5){
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
            .eraseToAnyView()
        }
    } else {
        return HStack (spacing: 5){
            Text("Equipos")
                .font(.subheadline)
            Spacer()
            Text("G")
                .modifier(modifierText(frameSize: 20))
            Text("P")
                .modifier(modifierText(frameSize: 20))
            Text("PCT")
                .modifier(modifierText(frameSize: 35))
            Text("JV")
                .modifier(modifierText(frameSize: 35))
        }
        .eraseToAnyView()
    }
}

struct modifierText: ViewModifier {
    
    @State var frameSize: CGFloat?
    @State var font: Font = .subheadline
    
    func body(content: Content) -> some View {
    return content
        .font(font)
        .frame(width: frameSize)
        .multilineTextAlignment(.leading)
    }
}
