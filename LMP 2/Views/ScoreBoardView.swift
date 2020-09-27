//
//  ScoreBoardView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ScoreBoardView: View {
       
    @ObservedObject var viewModel = ViewModel()
    @State private var isVisible = false
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            ScrollView (showsIndicators: false) {
                VStack (spacing: 10) {
                    TopHeaderView(viewModel: viewModel, title: "Scoreboards", showCalendarButton: true).padding(.bottom, 10)
                    Group {
                        if viewModel.showActivityIndicator {
                            LoadingView()
                                .modifier(AnimationEmptyCell(viewModel: viewModel, isVisible: $isVisible))
                            
                        } else if viewModel.gamesMLB.isEmpty {
                            EmptyGamesView()
                                .modifier(AnimationEmptyCell(viewModel: viewModel, isVisible: $isVisible))
                        } else {
                            ForEach(viewModel.gamesMLB) { date in
                                ForEach(date.games.sorted { $0.status.valueOrder < $1.status.valueOrder }) { game in
                                    scoreBoardStatus(model: game)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 70)
            }
        }
    }
    func scoreBoardStatus(model: Games) -> some View {
        return Group {
            switch model.status.abstractGameState {
            case "Live":
                NavigationLink(destination: GameContentView(viewModel: self.viewModel, gamePk: model.gamePk)) {
                    GameLiveView(teams: model.teams, linescore: model.linescore, status: model.status)
                }
            case "Preview":
                GamePreview(teams: model.teams, status: model.status, games: model)
            case "Final":
                NavigationLink(destination: GameContentView(viewModel: self.viewModel, gamePk: model.gamePk)) {
                    GameFinalView(teams: model.teams, status: model.status)
                }
            default:
                EmptyGamesView()
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
        .modifier(AnimationCell(viewModel: viewModel, isVisible: $isVisible))
        
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
    }
}

struct GamePostponedView: View {
    
    var teams: Teams
    
    var body: some View {
        HStack{
            TeamView(teamName: "\(teams.away.team.id)", wins: teams.away.leagueRecord.wins, losses: teams.away.leagueRecord.losses)
            TeamView(teamName: "\(teams.home.team.id)", wins: teams.home.leagueRecord.wins, losses: teams.home.leagueRecord.losses)
        }
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
            Divider().foregroundColor(.secondary).padding(.horizontal)
            BoxScoreview(team: teams, linescore: linescore, status: status)
            Divider().foregroundColor(.secondary).padding(.horizontal)
            HStack {
                InningView(linescore: linescore)
                DiamondView(linescore: linescore)
                BSOView(linescore: linescore)
            }
        }
    }
}

struct GamePreview: View {
    
    var teams: Teams
    var status: Status
    var games: Games
    
    var body: some View {
        VStack (spacing: 0){
            HStack {
                TeamView(teamName: "\(teams.away.team.id)", wins: teams.away.leagueRecord.wins, losses: teams.away.leagueRecord.losses)
                VStack {
                    Text("VS.")
                        .font(.system(.title, design: .rounded))
                        .bold()
                    Text(games.gameDate.hourFormat())
                        .font(.system(.subheadline, design: .rounded))
                        .bold()
                }
                TeamView(teamName: "\(teams.home.team.id)", wins: teams.home.leagueRecord.wins, losses: teams.home.leagueRecord.losses)
            }
            Divider().padding(.horizontal)
            ProbablePitcherView(team: teams)
        }
    }
}


struct LoadingView: View {
    
    var body: some View {
        Spacer(minLength: UIScreen.main.bounds.height / 3)
        HStack (spacing: 5) {
            ProgressView()
            Text("Cargando")
                .foregroundColor(.secondary)
        }
    }
}

struct EmptyGamesView: View {
    var body: some View {
        Spacer(minLength: UIScreen.main.bounds.height / 3)
        HStack (spacing: 5) {
            Text("No hay juegos programados.")
                .foregroundColor(.secondary)
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
                .frame(width: 50, height: 50, alignment: .center)
            Text("(\(wins)-\(losses))")
                .font(.caption)
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
                .font(.system(size: 45, weight: .regular, design: .rounded))
                .foregroundColor(.primary)
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
            TeamNameView(team: team)
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
        ScrollView(.horizontal, showsIndicators: true) {
            VStack (alignment: .leading) {
                HStack (spacing: 5) {
                    ForEach(1..<(linescore?.getNumberInnings ?? 9) + 1) { inning in
                        Text("\(inning)")
                            .foregroundColor(.secondary)
                            .modifier(modifierText(frameSize: 15, font: .caption))
                    }
                }
                
                HStack (spacing: 5) {
                    ForEach(linescore?.innings ?? []) { score in
                        VStack {
                            Text("\(score.away?.runs ?? 0)")
                                .foregroundColor(.primary)
                                .fontWeight((score.away?.runs ?? 0) > 0 ? .bold : .none)
                                .modifier(modifierText(frameSize: 15, font: .caption))
                        Text("\(score.home?.runs ?? 0)")
                            .foregroundColor(.primary)
                            .fontWeight((score.home?.runs ?? 0) > 0 ? .bold : .none)
                            .modifier(modifierText(frameSize: 15, font: .caption))
                        }
                    }
                }
            }
        }.frame(width: 175, alignment: .center)
    }
}

struct TeamNameView: View {
    
    var team: Teams
    
    var body: some View {
        VStack (alignment: .leading) {
            Group {
                Text("TEAM").foregroundColor(.secondary)
                Text(team.away.team.teamName)
                Text(team.home.team.teamName)
            }
            .foregroundColor(.primary)
            .modifier(modifierText(font: .caption))
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
                    Text(self.header[item])
                        .foregroundColor(.secondary)
                        .modifier(modifierText(frameSize: 15, font: .caption))
                }
            }
            HStack (spacing: 5) {
                Text("\(linescore?.teams.away.runs ?? 0)")
                    .foregroundColor(.primary)
                    .fontWeight((linescore?.teams.away.runs ?? 0) > 0 ? .bold : .none)
                    .modifier(modifierText(frameSize: 15, font: .caption))
                Text("\(linescore?.teams.away.hits ?? 0)")
                    .foregroundColor(.primary)
                    .fontWeight((linescore?.teams.away.hits ?? 0) > 0 ? .bold : .none)
                    .modifier(modifierText(frameSize: 15, font: .caption))
                Text("\(linescore?.teams.away.errors ?? 0)")
                    .foregroundColor(.primary)
                    .fontWeight((linescore?.teams.away.errors ?? 0) > 0 ? .bold : .none)
                    .modifier(modifierText(frameSize: 15, font: .caption))
            }
            HStack (spacing: 5) {
                Text("\(linescore?.teams.home.runs ?? 0)")
                    .foregroundColor(.primary)
                    .fontWeight((linescore?.teams.away.runs ?? 0) > 0 ? .bold : .none)
                    .modifier(modifierText(frameSize: 15, font: .caption))
                Text("\(linescore?.teams.home.hits ?? 0)")
                    .foregroundColor(.primary)
                    .fontWeight((linescore?.teams.away.hits ?? 0) > 0 ? .bold : .none)
                    .modifier(modifierText(frameSize: 15, font: .caption))
                Text("\(linescore?.teams.home.errors ?? 0)")
                    .foregroundColor(.primary)
                    .fontWeight((linescore?.teams.away.errors ?? 0) > 0 ? .bold : .none)
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
                .foregroundColor(.primary)
                .font(.system(.headline))
            Text(linescore?.currentInningOrdinal ?? "0")
                .foregroundColor(.primary)
                .font(.system(size: 20))
        }.frame(maxWidth: .infinity, minHeight: 100)
    }
}

struct DiamondView: View {
    
    var linescore: Linescore?
    
    var body: some View {
        ZStack {
            Image(systemName: (linescore?.offense.diamondState[0]) ?? "square")
                .foregroundColor(.primary)
                .font(.system(size: 30, weight: .ultraLight))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: 22, y: 10)
            Image(systemName: (linescore?.offense.diamondState[1]) ?? "square")
                .foregroundColor(.primary)
                .font(.system(size: 30, weight: .ultraLight))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: 0, y: -12)
            Image(systemName: (linescore?.offense.diamondState[2]) ?? "square")
                .foregroundColor(.primary)
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
                        .foregroundColor(.primary)
                        .font(.system(size: 12))
                }
            }
            HStack {
                Text("S")
                    .modifier(textModifier(font: .headline, fontColor: .primary, fontDesing: .default))
                ForEach(linescore?.strikesState ?? [], id: \.self) { item in
                    Image(systemName: item)
                        .foregroundColor(.primary)
                        .font(.system(size: 12))
                }
            }
            HStack {
                Text("O")
                    .modifier(textModifier(font: .headline, fontColor: .primary, fontDesing: .default))
                ForEach(linescore?.outsState ?? [], id: \.self) { item in
                    Image(systemName: item)
                        .foregroundColor(.primary)
                        .font(.system(size: 12))
                }
            }.offset(x: -2, y: 0)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
    }
}

struct ProbablePitcherView: View {
    
    var team: Teams
    
    var body: some View{
        VStack {
            Text("Probable Pitcher")
                .font(.caption)
                .foregroundColor(.secondary)
            HStack {
                PitcherAwayView(pitcher: team.away)
                Spacer()
                PitcherHomeView(pitcher: team.home)
            }.padding()
        }
    }
}


struct PitcherAwayView: View {
    
    var pitcher: TeamData
    
    var body: some View {
        HStack {
            WebImage(url: pitcher.getProbablePicher().imageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .frame(width: 50, height: 50, alignment: .center)
            ProbablePitcherStatsView(pitcher: pitcher, alignment: .leading)
                .redacted(reason: pitcher.getProbablePicher().boxscoreName == "unknown" ? .placeholder : .init())
        }.frame(maxWidth: .infinity)
    }
}

struct PitcherHomeView: View {
    
    var pitcher: TeamData
    
    var body: some View {
        HStack {
            ProbablePitcherStatsView(pitcher: pitcher, alignment: .trailing)
                .redacted(reason: pitcher.getProbablePicher().boxscoreName == "unknown" ? .placeholder : .init())
            WebImage(url: pitcher.getProbablePicher().imageURL, options: .forceTransition)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .frame(width: 50, height: 50, alignment: .center)
        }.frame(maxWidth: .infinity)
        
    }
}

struct ProbablePitcherStatsView: View {
    
    var pitcher: TeamData
    var alignment: HorizontalAlignment
    
    var body: some View {
        VStack (alignment: alignment) {
            Text(pitcher.getProbablePicher().boxscoreName)
                .font(.caption)
                .foregroundColor(.secondary)
                .fontWeight(.bold)
            Text("\(pitcher.getProbablePicher().pitchHand.code.appending("HP")) #\(pitcher.getProbablePicher().primaryNumber ?? "--")")
                .font(.caption)
                .foregroundColor(.secondary)
            ForEach(pitcher.getProbablePicher().getStats() ?? [], id: \.id) { stat in
                Text("\(stat.stats.wins ?? 0)-\(stat.stats.losses ?? 0), \(stat.stats.era ?? "--") ERA")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
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

struct AnimationEmptyCell: ViewModifier {
    
    @ObservedObject var viewModel = ViewModel()
    @Binding var isVisible: Bool
    
    func body(content: Content) -> some View {
        return content
            .opacity(self.isVisible ? 0 : 1)
            .offset(x: 0, y: self.isVisible ? 70 : 0)
            .onAppear {
                withAnimation(.spring()) {
                    if self.viewModel.gamesMLB.isEmpty {
                        self.isVisible = false
                    } else {
                        self.isVisible = true
                }
            }
        }
    }
}

struct AnimationCell: ViewModifier {
    
    @ObservedObject var viewModel = ViewModel()
    @Binding var isVisible: Bool
    
    func body(content: Content) -> some View {
        return content
            .opacity(self.isVisible ? 1 : 0)
            .offset(x: 0, y: self.isVisible ? 0 : 70)
            .onAppear {
                withAnimation(.spring()) {
                    if self.viewModel.gamesMLB.isEmpty {
                        self.isVisible = false
                    } else {
                        self.isVisible = true
                }
            }
        }
    }
}
