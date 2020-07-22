//
//  ScoreBoardView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import URLImage

struct ScoreBoardView: View, Equatable {
        
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        Group {
            if viewModel.showActivityIndicator {
                LoadingView(isLoading: $viewModel.showActivityIndicator)
            } else if viewModel.gamesMLB.isEmpty {
                EmptyGamesView()
            } else {
                ForEach(viewModel.gamesMLB, id: \.id) { date in
                    ForEach(date.games, id: \.id) { game in
                        Group {
                            if game.status.abstractGameState == "Live" {
                                GameLiveView(teams: game.teams, linescore: game.linescore, status: game.status)
                            } else if game.status.abstractGameState == "Preview" {
                                GamePreview(teams: game.teams, status: game.status, games: game)
                            } else if game.status.abstractGameState == "Final" {
                                GameFinalView(teams: game.teams, status: game.status)
                            }
                        }
                    }
                }
            }
        }
    }
    static func == (lhs: ScoreBoardView, rhs: ScoreBoardView) -> Bool {
        return lhs.viewModel.gamesMLB == rhs.viewModel.gamesMLB
    }
}
struct ScoreBoardView_Previews: PreviewProvider {
    static var previews: some View {
        
            ScoreBoardView(viewModel: ViewModel())
    }
}

//MARK: - Status Game Views

struct GameFinalView: View {
    
    var teams: Teams
    var status: Status
    
    var body: some View {
            HStack {
                TeamView(teamName: "\(teams.away.team.id)", wins: teams.away.leagueRecord.wins, losses: teams.away.leagueRecord.losses)
                ScoreView(teams: teams, status: status)
                TeamView(teamName: "\(teams.home.team.id)", wins: teams.home.leagueRecord.wins, losses: teams.home.leagueRecord.losses)
            }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct GamePostponedView: View {
    
    var teams: Teams
    
    var body: some View {
        HStack {
            TeamView(teamName: "\(teams.away.team.id)", wins: teams.away.leagueRecord.wins, losses: teams.away.leagueRecord.losses)
            TeamView(teamName: "\(teams.home.team.id)", wins: teams.home.leagueRecord.wins, losses: teams.home.leagueRecord.losses)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
        
    }
}

struct GameLiveView: View {
    
    var teams: Teams
    var linescore: Linescore?
    var status: Status
    
    var body: some View {
        
        VStack (spacing: 0) {
            HStack {
                TeamView(teamName: "\(teams.away.team.id)", wins: teams.away.leagueRecord.wins, losses: teams.away.leagueRecord.losses)
                ScoreView(teams: teams, status: status)
                TeamView(teamName: "\(teams.home.team.id)", wins: teams.home.leagueRecord.wins, losses: teams.home.leagueRecord.losses)
            }
            Divider().foregroundColor(.secondary)
            BoxScoreview(team: teams, linescore: linescore, status: status)
            Divider().foregroundColor(.secondary)
            HStack {
                InningView(linescore: linescore)
                DiamondView(linescore: linescore)
                BSOView(linescore: linescore)
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct GamePreview: View {
    
    var teams: Teams
    var status: Status
    var games: Games
    
    var body: some View {
        VStack{
        HStack {
            TeamView(teamName: "\(teams.away.team.id)", wins: teams.away.leagueRecord.wins, losses: teams.away.leagueRecord.losses)
            VStack {
                Text("VS.")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                Text(games.time)
                    .font(.system(.headline, design: .rounded))
                    .bold()
            }
            TeamView(teamName: "\(teams.home.team.id)", wins: teams.home.leagueRecord.wins, losses: teams.home.leagueRecord.losses)
        }
             ProbablePitcherView(pitcher: teams)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}


struct LoadingView: View {
    
    @Binding var isLoading: Bool
    
    var body: some View {
        HStack {
            ActivityIndicator(showIndicator: $isLoading, style: .medium).foregroundColor(.secondary)
            Text("Cargando")
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct EmptyGamesView: View {
    var body: some View {
       HStack {
            Text("No hay juegos")
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct ProbablePitcherView: View {
    
    var pitcher: Teams
    
    var body: some View{
        VStack {
        URLImage((pitcher.away.probablePitcher?.imageURL ?? URL(string: "https://content.mlb.com/images/headshots/current/60x60/657140@2x.png"))!,
                     placeholder: Image(systemName: "person.crop.circle"),
                     content: {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
            })
            .frame(width: 60, height: 60, alignment: .center)
        }
    }
}

//MARK: - Views

struct TeamView: View {
    
    var teamName: String
    var wins, losses: Int
    
    var body: some View {
        VStack {
            Image(teamName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55, alignment: .center)
            Text("(\(wins)-\(losses))")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct ScoreView: View {
    
    var teams: Teams
    var status: Status
    
    var body: some View {
        VStack {
            Text("\(teams.away.score ?? 0)-\(teams.home.score ?? 0)")
                .font(.system(size: 50, weight: .regular, design: .rounded))
            Text(status.detailedState)
                .foregroundColor(.secondary)
        }.frame(maxWidth: .infinity, minHeight: 100)
    }
}


struct BoxScoreview: View {
    
    var team: Teams
    var linescore: Linescore?
    var status: Status
    
    var body: some View {
        HStack {
            TeamNameView(team: team, status: status)
            Spacer()
            InningScoreView(linescore: linescore)
            Spacer()
            RHEView(linescore: linescore)
        }
        .padding()
    }
}

struct InningScoreView: View {
    
    var linescore: Linescore?
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (spacing: 5) {
                ForEach(1..<10) { inning in
                    Text("\(inning)")
                        .foregroundColor(.secondary)
                        .modifier(modifierText(frameSize: 15, font: .caption))
                }
            }
            HStack (spacing: 5) {
                ForEach(linescore?.getScore ?? [], id: \.id) { score in
                    VStack {
                        Text(score.away?.getRuns ?? "")
                            .modifier(modifierText(frameSize: 15, font: .caption))
                        Text(score.home?.getRuns ?? "")
                            .modifier(modifierText(frameSize: 15, font: .caption))
                    }
                }
            }
        }
    }
}

struct TeamNameView: View {
    
    var team: Teams
    var status: Status
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(status.detailedState)
                .modifier(modifierText(font: .caption))
            HStack {
            Text(team.away.team.teamName)
                .modifier(modifierText(font: .caption))
            }
            HStack {
            Text(team.home.team.teamName)
                .modifier(modifierText(font: .caption))
            }
        }.frame(height: 40, alignment: .bottom)
    }
}

struct RHEView: View {
    
    var header = ["R", "H", "E"]
    var linescore: Linescore?
    
    var body: some View {
        VStack {
            HStack (spacing: 5) {
                ForEach(0..<header.count) { item in
                    Text(self.header[item]).foregroundColor(.secondary)
                        .modifier(modifierText(frameSize: 15, font: .caption))
                }
            }
            HStack (spacing: 5) {
                Text("\(linescore?.teams.away.runs ?? 0)")
                    .modifier(modifierText(frameSize: 15, font: .caption))
                Text("\(linescore?.teams.away.hits ?? 0)")
                    .modifier(modifierText(frameSize: 15, font: .caption))
                Text("\(linescore?.teams.away.errors ?? 0)")
                    .modifier(modifierText(frameSize: 15, font: .caption))
            }
            HStack (spacing: 5) {
                Text("\(linescore?.teams.home.runs ?? 0)")
                    .modifier(modifierText(frameSize: 15, font: .caption))
                Text("\(linescore?.teams.home.hits ?? 0)")
                    .modifier(modifierText(frameSize: 15, font: .caption))
                Text("\(linescore?.teams.home.errors ?? 0)")
                    .modifier(modifierText(frameSize: 15, font: .caption))
            }
        }
    }
}

struct InningView: View {
    
    var linescore: Linescore?
    
    var body: some View {
        HStack {
            Image(systemName: linescore?.inningArrowStatus ?? "arrowtriangle.up.fill")
                .font(.system(.headline))
            Text(linescore?.currentInningOrdinal ?? "0")
                .font(.system(size: 20))
        }.frame(maxWidth: .infinity, minHeight: 100)
    }
}

struct DiamondView: View {
    
    var linescore: Linescore?
    
    var body: some View {
        ZStack {
            Image(systemName: (linescore?.offense.diamondState[0]) ?? "square")
                .font(.system(size: 30, weight: .ultraLight))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: 22, y: 10)
            Image(systemName: (linescore?.offense.diamondState[1]) ?? "square")
                .font(.system(size: 30, weight: .ultraLight))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: 0, y: -12)
            Image(systemName: (linescore?.offense.diamondState[2]) ?? "square")
                .font(.system(size: 30, weight: .ultraLight))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: -22, y: 10)
        }.frame(maxWidth: .infinity, minHeight: 100)
    }
}

struct BSOView: View {
    
    var linescore: Linescore?
    
    var body: some View {
        VStack (alignment: .leading, spacing: 2) {
            HStack {
                Text("B")
                    .modifier(textModifier(font: .headline, fontColor: .primary, fontDesing: .default))
                ForEach(linescore?.ballsState ?? [], id: \.self) { item in
                    Image(systemName: item)
                        .imageScale(.small)
                }
            }
            HStack {
                Text("S")
                    .modifier(textModifier(font: .headline, fontColor: .primary, fontDesing: .default))
                ForEach(linescore?.strikesState ?? [], id: \.self) { item in
                    Image(systemName: item)
                        .imageScale(.small)
                }
            }
            HStack {
                Text("O")
                    .modifier(textModifier(font: .headline, fontColor: .primary, fontDesing: .default))
                ForEach(linescore?.outsState ?? [], id: \.self) { item in
                    Image(systemName: item)
                        .imageScale(.small)
                }
            }.offset(x: -2, y: 0)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
    }
}

struct textModifier: ViewModifier {
    
    @State var font: Font = .headline
    @State var fontColor: Color = .primary
    @State var fontDesing: Font.Design = .rounded
    
    func body(content: Content) -> some View {
        return content
            .font(font)
            .foregroundColor(fontColor)
            
    }
}

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var showIndicator: Bool
    
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .medium)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if showIndicator {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
