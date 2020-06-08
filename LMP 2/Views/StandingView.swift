//
//  StandingView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 21/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StandingView: View {
    
    @ObservedObject var standingData = ViewModel()
    @State private var buttonText = "Regular"
    @State private var bottomPickerValue = 0
    @State private var showActionSheet = false
     
    var body: some View {
        VStack (alignment: .center) {
            Button(action: {
                self.showActionSheet = true
            }) {
                HStack {
                    Text(buttonText)
                    Image(systemName: "chevron.down")
                }.foregroundColor(Color(.systemBlue))
                 .padding(3)
            }.buttonStyle(PlainButtonStyle())
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text(""), buttons: [
                        .default(Text("Regular")){
                            self.buttonText = "Regular"
                            self.bottomPickerValue = 0
                        },
                        .default(Text("Playoffs")){
                            self.buttonText = "Playoffs"
                            self.bottomPickerValue = 0
                        },
                        .cancel()])
            }
            Picker(selection: $bottomPickerValue, label: Text("")) {
                if self.buttonText == "Regular" {
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
            
            VStack {
                showHeaderView(bottom: self.bottomPickerValue, type: self.buttonText)
                Divider()
                standingType(type: self.bottomPickerValue, buttonValue: self.buttonText)
            }
            
            
        }
        .frame(minHeight: 150, maxHeight: 529, alignment: .top)
        .padding()
        .background(Color("BackgroundCell"))
        .cornerRadius(10)
    }
    
    func standingType(type: Int, buttonValue: String) -> some View {
        
        if buttonValue == "Regular" {
            switch type {
            case 0:
                return ForEach(self.standingData.standingList.first, id: \.id) { item in
                    StandingRegularView(team_name: item.team_name, name: item.name, wins: "\(item.wins)", losses: "\(item.losses)", percent: item.percent, gb: item.gb, pts: item.pts)
                }
                .eraseToAnyView()
                
            case 1:
                return ForEach(self.standingData.standingList.second, id: \.id) { item in
                    StandingRegularView(team_name: item.team_name, name: item.name, wins: "\(item.wins)", losses: "\(item.losses)", percent: item.percent, gb: item.gb, pts: item.pts)
                }
                .eraseToAnyView()
            case 2:
                return ForEach(self.standingData.standingList.general, id: \.id) { item in
                    StandingRegularView(team_name: item.team_name, name: item.name, wins: "\(item.wins)", losses: "\(item.losses)", percent: item.percent, gb: item.gb, pts: item.pts)
                }
                .eraseToAnyView()
            case 3:
                return ForEach(self.standingData.standingList.points, id: \.id) { item in
                    StandingPointsView(team_name: item.team_name, name: item.name, first: item.first, second: item.second, total: item.total)
                }
                    .eraseToAnyView()
            default:
                return ForEach(self.standingData.standingList.first, id: \.id) { item in
                    StandingRegularView(team_name: item.team_name, name: item.name, wins: "\(item.wins)", losses: "\(item.losses)", percent: item.percent, pts: item.pts)
                }
                .eraseToAnyView()
            }
        }
        else {
            
            switch type {

            case 1:
                return ForEach(self.standingData.standingList.playoffs!.semifinal, id: \.away_team_name) { item in
                    StandingPlayoffsView(away_team_name: item.away_team_name, away_image: item.away_image, away_wins: "\(item.away_wins)", away_losses: "\(item.away_losses)", away_percent: item.away_percent, away_games_played: item.away_games_played, home_team_name: item.home_team_name, home_image: item.home_image, home_wins: "\(item.home_wins)", home_losses: "\(item.home_losses)", home_percent: item.home_percent, home_games_played: item.home_games_played)
                    
                }
                .eraseToAnyView()
            case 2:
                return ForEach(self.standingData.standingList.playoffs!.final, id: \.away_team_name) { item in
                    StandingPlayoffsView(away_team_name: item.away_team_name, away_image: item.away_image, away_wins: "\(item.away_wins)", away_losses: "\(item.away_losses)", away_percent: item.away_percent, away_games_played: item.away_games_played, home_team_name: item.home_team_name, home_image: item.home_image, home_wins: "\(item.home_wins)", home_losses: "\(item.home_losses)", home_percent: item.home_percent, home_games_played: item.home_games_played)
                    
                }
                .eraseToAnyView()
            default:
                return ForEach(self.standingData.standingList.playoffs!.repesca, id: \.away_team_name) { item in
                    StandingPlayoffsView(away_team_name: item.away_team_name, away_image: item.away_image, away_wins: "\(item.away_wins)", away_losses: "\(item.away_losses)", away_percent: item.away_percent, away_games_played: item.away_games_played, home_team_name: item.home_team_name, home_image: item.home_image, home_wins: "\(item.home_wins)", home_losses: "\(item.home_losses)", home_percent: item.home_percent, home_games_played: item.home_games_played)
                    
                }
                .eraseToAnyView()
            }
        }
    }
}

struct StandingView_Previews: PreviewProvider {
    static var previews: some View {

            StandingView(standingData: ViewModel())
            
    }
}

struct StandingRegularView: View {
    
    var team_name, name, wins, losses, percent, gb, pts: String?
    
    
    var body: some View {
        
        VStack {
            HStack (spacing: 5) {
                Image(team_name!)
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                Text(name!)
                    .modifier(modifierText(font: .caption))
                Spacer()
                Text(wins!)
                    .modifier(modifierText(frameSize: 20, font: .caption))
                Text(losses!)
                    .modifier(modifierText(frameSize: 20, font: .caption))
                Text(percent!)
                    .modifier(modifierText(frameSize: 30, font: .caption))
                Text(gb!)
                    .modifier(modifierText(frameSize: 30, font: .caption))
                Text(pts!)
                    .modifier(modifierText(frameSize: 30, font: .caption))
                
            }
            Divider()
        }
    }
}

struct StandingPointsView: View {
    
    var team_name, name, first, second, total: String?
    
    var body: some View {
        VStack {
            HStack (spacing: 5) {
                Image(team_name!)
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                Text(name!)
                    .modifier(modifierText(font: .caption))
                Spacer()
                Text(first!)
                    .modifier(modifierText(frameSize: 30, font: .caption))
                Text(second!)
                    .modifier(modifierText(frameSize: 30, font: .caption))
                Text(total!)
                    .modifier(modifierText(frameSize: 40, font: .caption))
            }
            Divider()
        }
    }
}

struct StandingPlayoffsView: View {
    
    var away_team_name, away_image, away_wins, away_losses, away_percent, away_games_played, home_team_name, home_image, home_wins, home_losses, home_percent, home_games_played: String?
    
    var body: some View {
        VStack {
            HStack (spacing: 5) {
                Image(away_image!)
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                Text(away_team_name!)
                    .modifier(modifierText(font: .caption))
                Spacer()
                Text(away_wins!)
                    .modifier(modifierText(frameSize: 20, font: .caption))
                Text(away_losses!)
                    .modifier(modifierText(frameSize: 20, font: .caption))
                Text(away_percent!)
                    .modifier(modifierText(frameSize: 30, font: .caption))
                Text(away_games_played!)
                    .modifier(modifierText(frameSize: 30, font: .caption))
            }
            HStack (spacing: 5) {
                Image(home_image!)
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                Text(home_team_name!)
                    .modifier(modifierText(font: .caption))
                Spacer()
                Text(home_wins!)
                    .modifier(modifierText(frameSize: 20, font: .caption))
                Text(home_losses!)
                    .modifier(modifierText(frameSize: 20, font: .caption))
                Text(home_percent!)
                    .modifier(modifierText(frameSize: 30, font: .caption))
                Text(home_games_played!)
                    .modifier(modifierText(frameSize: 30, font: .caption))
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
                    .modifier(modifierText(frameSize: 20))
                Text("P")
                    .modifier(modifierText(frameSize: 20))
                Text("PCT")
                    .modifier(modifierText(frameSize: 30))
                Text("DIF")
                    .modifier(modifierText(frameSize: 30))
                Text("PTS")
                    .modifier(modifierText(frameSize: 30))
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
                .modifier(modifierText(frameSize: 30))
            Text("JV")
                .modifier(modifierText(frameSize: 30))
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
