//
//  StandingView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 21/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StandingView: View {
    
    @ObservedObject var standingData = RowViewModel()
    @State private var statusPicker = 0
    
    var body: some View {
        VStack (alignment: .center) {
            Picker(selection: $statusPicker, label: Text("")) {
                Text("Regular").tag(0)
                Text("Playoffs").tag(1)
                
            }.pickerStyle(SegmentedPickerStyle())
            Picker(selection: self.$standingData.standingType, label: Text("")) {
                if self.statusPicker == 0 {
                    Text("1ra Vuelta").tag(0)
                    Text("2da Vuelta").tag(1)
                    Text("General").tag(2)
                    Text("Puntos").tag(3)
                }
                else {
                    Text("Playoffs").tag(0)
                    Text("Semifinal").tag(1)
                    Text("Final").tag(2)
                }
            }.pickerStyle(SegmentedPickerStyle())
             .padding(.bottom)
             .animation(nil)
            
            headerStatus(status: self.standingData.standingType, type: self.statusPicker)
            standingType(type: self.standingData.standingType, status: self.statusPicker)
            
        }
        .padding()
        .background(Color("BackgroundCell"))
        .cornerRadius(10)
    }
    
    func standingType(type: Int, status: Int) -> some View {
        
        if status == 0 {
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

            StandingView(standingData: RowViewModel())
            
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
                    .font(.caption)
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(wins!)
                    .font(.caption)
                    .bold()
                    .frame(width: 20)
                    .multilineTextAlignment(.leading)
                Text(losses!)
                    .font(.caption)
                    .bold()
                    .frame(width: 20)
                    .multilineTextAlignment(.leading)
                Text(percent!)
                    .font(.caption)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                Text(gb!)
                    .font(.caption)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                Text(pts!)
                    .font(.caption)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                
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
                    .font(.caption)
                .bold()
                Spacer()
                Text(first!)
                    .font(.caption)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                Text(second!)
                    .font(.caption)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                Text(total!)
                    .font(.caption)
                    .bold()
                    .frame(width: 40)
                    .multilineTextAlignment(.leading)
                
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
                    .font(.caption)
                .bold()
                Spacer()
                Text(away_wins!)
                    .font(.caption)
                    .bold()
                    .frame(width: 20)
                    .multilineTextAlignment(.leading)
                Text(away_losses!)
                    .font(.caption)
                    .bold()
                    .frame(width: 20)
                    .multilineTextAlignment(.leading)
                Text(away_percent!)
                    .font(.caption)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                Text(away_games_played!)
                .font(.caption)
                    .bold()
                .frame(width: 30)
                .multilineTextAlignment(.leading)
            }
            HStack (spacing: 5) {
                Image(home_image!)
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                Text(home_team_name!)
                    .font(.caption)
                .bold()
                Spacer()
                Text(home_wins!)
                    .font(.caption)
                    .bold()
                    .frame(width: 20)
                    .multilineTextAlignment(.leading)
                Text(home_losses!)
                    .font(.caption)
                    .bold()
                    .frame(width: 20)
                    .multilineTextAlignment(.leading)
                Text(home_percent!)
                    .font(.caption)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                Text(home_games_played!)
                .font(.caption)
                    .bold()
                .frame(width: 30)
                .multilineTextAlignment(.leading)
            }
            Divider()
        }
    }
}

struct HeaderRegularView: View {
    
    var body: some View {
        
        VStack {
            HStack (spacing: 5){
                Text("Equipos")
                    .font(.subheadline)
                    .bold()
                
                Spacer()
                Text("G")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 20)
                    .multilineTextAlignment(.leading)
                Text("P")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 20)
                    .multilineTextAlignment(.leading)
                Text("%")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                Text("JV")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                Text("PTS")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                    .font(.subheadline)

            }
            Divider()
        }
    }
}

struct HeaderPointsView: View {
    
    var body: some View {
        
        VStack {
            
            HStack (spacing: 5) {
                Text("Equipos")
                    .font(.subheadline)
                    .bold()
                Spacer()
                Text("1V")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                Text("2V")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                Text("Total")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 40)
                    .multilineTextAlignment(.leading)
            }
            Divider()
        }
    }
}

struct HeaderPlayoffsView: View {
    
    var body: some View {
        
        VStack {
            HStack (spacing: 5){
                Text("Equipos")
                    .font(.subheadline)
                    .bold()
                
                Spacer()
                Text("G")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 20)
                    .multilineTextAlignment(.leading)
                Text("P")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 20)
                    .multilineTextAlignment(.leading)
                Text("%")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)
                Text("JV")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 30)
                    .multilineTextAlignment(.leading)

            }
            Divider()
        }
    }
}

struct headerView: View {
    
    @Binding var type: Int
    @Binding var status: Int
    
    var body: some View {
        
           headerStatus(status: status, type: type)
        }
    }
    func headerStatus(status: Int, type: Int) -> some View {
        if type == 0 {
            switch status {
            case 3:
                return VStack {
                    
                    HStack (spacing: 5) {
                        Text("Equipos")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text("1V")
                            .font(.subheadline)
                            .bold()
                            .frame(width: 30)
                            .multilineTextAlignment(.leading)
                        Text("2V")
                            .font(.subheadline)
                            .bold()
                            .frame(width: 30)
                            .multilineTextAlignment(.leading)
                        Text("Total")
                            .font(.subheadline)
                            .bold()
                            .frame(width: 40)
                            .multilineTextAlignment(.leading)
                    }
                    Divider()
                }
                .eraseToAnyView()
            default:
                return VStack {
                    HStack (spacing: 5){
                        Text("Equipos")
                            .font(.subheadline)
                            .bold()
                        
                        Spacer()
                        Text("G")
                            .font(.subheadline)
                            .bold()
                            .frame(width: 20)
                            .multilineTextAlignment(.leading)
                        Text("P")
                            .font(.subheadline)
                            .bold()
                            .frame(width: 20)
                            .multilineTextAlignment(.leading)
                        Text("%")
                            .font(.subheadline)
                            .bold()
                            .frame(width: 30)
                            .multilineTextAlignment(.leading)
                        Text("JV")
                            .font(.subheadline)
                            .bold()
                            .frame(width: 30)
                            .multilineTextAlignment(.leading)
                        Text("PTS")
                            .font(.subheadline)
                            .bold()
                            .frame(width: 30)
                            .multilineTextAlignment(.leading)
                            .font(.subheadline)

                    }
                    Divider()
                }
            .eraseToAnyView()
        }
        } else {
          return VStack {
                HStack (spacing: 5){
                    Text("Equipos")
                        .font(.subheadline)
                        .bold()
                    
                    Spacer()
                    Text("G")
                        .font(.subheadline)
                        .bold()
                        .frame(width: 20)
                        .multilineTextAlignment(.leading)
                    Text("P")
                        .font(.subheadline)
                        .bold()
                        .frame(width: 20)
                        .multilineTextAlignment(.leading)
                    Text("%")
                        .font(.subheadline)
                        .bold()
                        .frame(width: 30)
                        .multilineTextAlignment(.leading)
                    Text("JV")
                        .font(.subheadline)
                        .bold()
                        .frame(width: 30)
                        .multilineTextAlignment(.leading)

                }
                Divider()
            }
        .eraseToAnyView()
        }
}


