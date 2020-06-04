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
    @State private var statusTopPicker = 0
    @State private var statusBottomPicker = 0
     
    
    var body: some View {
        VStack (alignment: .center) {
            Picker(selection: $statusBottomPicker, label: Text("")) {
                Text("Regular").tag(0)
                Text("Playoffs").tag(1)
                
            }.pickerStyle(SegmentedPickerStyle())
            Picker(selection: $statusTopPicker, label: Text("")) {
                if self.statusBottomPicker == 0 {
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
            
            headerStatus(status: self.statusTopPicker, type: self.statusBottomPicker)
            standingType(type: self.statusTopPicker, status: self.statusBottomPicker)
            
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
                    .multilineTextAlignment(.leading)
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
                    .font(.caption)
                .bold()
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
                    .font(.caption)
                .bold()
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
                    .font(.caption)
                .bold()
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
                        Spacer()
                        Text("1V")
                            .modifier(modifierText(frameSize: 30))
                        Text("2V")
                            .modifier(modifierText(frameSize: 30))
                        Text("Total")
                            .modifier(modifierText(frameSize: 40))
                    }
                    Divider()
                }
                .eraseToAnyView()
            default:
                return VStack {
                    HStack (spacing: 5){
                        Text("Equipos")
                            .font(.subheadline)
                        Spacer()
                        Text("G")
                            .modifier(modifierText(frameSize: 20))
                        Text("P")
                            .modifier(modifierText(frameSize: 20))
                        Text("%")
                            .modifier(modifierText(frameSize: 30))
                        Text("JV")
                            .modifier(modifierText(frameSize: 30))
                        Text("PTS")
                            .modifier(modifierText(frameSize: 30))

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
                    Spacer()
                    Text("G")
                        .modifier(modifierText(frameSize: 20))
                    Text("P")
                        .modifier(modifierText(frameSize: 20))
                    Text("%")
                        .modifier(modifierText(frameSize: 30))
                    Text("JV")
                       .modifier(modifierText(frameSize: 30))
                    
                }
                Divider()
            }
        .eraseToAnyView()
        }
}

struct modifierText: ViewModifier {
    
    @State var frameSize: CGFloat
    @State var font: Font = .subheadline
    
    func body(content: Content) -> some View {
    return content
        .font(font)
        .frame(width: frameSize)
        .multilineTextAlignment(.leading)
        
    }
}





/*struct HeaderRegularView: View {
    
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
}*/
