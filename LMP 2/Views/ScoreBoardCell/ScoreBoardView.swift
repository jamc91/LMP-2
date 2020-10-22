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
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            ScrollView (showsIndicators: false) {
                VStack (spacing: 10) {
                    TopHeaderView(viewModel: viewModel, title: "Scoreboards", showCalendarButton: true).padding(.bottom, 10)
                    Group {
                        if viewModel.showActivityIndicator {
                            LoadingView()
                            
                        } else if viewModel.gamesMLB.isEmpty {
                            EmptyGamesView()
                            
                        } else {
                            ForEach(viewModel.gamesMLB) { date in
                                if !date.games.filter { $0.teams.away.team.sport.id == 17 }.isEmpty {
                                    Section (header: HeaderSectionView(title: "Mexican Pacific League")) {
                                        ForEach(date.games.filter { $0.teams.away.team.sport.id == 17 }) { game in
                                            scoreBoardStatus(model: game)
                                            
                                        }
                                    }
                                }
                                if !date.games.filter { $0.teams.away.team.sport.id == 1 }.isEmpty {
                                    Section (header: HeaderSectionView(title: "Major League Baseball")) {
                                        ForEach(date.games.filter { $0.teams.away.team.sport.id == 1 }) { game in
                                            scoreBoardStatus(model: game)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding([.horizontal, .bottom], 20)
            }
        }
    }
    func scoreBoardStatus(model: Games) -> some View {
   
        enum gameState: String {
            case final = "Final", preview = "Preview", live = "Live"
        }
        return Group {
            switch gameState(rawValue: model.status.abstractGameState) {
            case .final:
               Button {
                    viewModel.fetchData(url: URL(string: "https://statsapi.mlb.com/api/v1.1/game/\(model.gamePk)/feed/live?language=es")!, placeholder: ContentResults.default) { (content: ContentResults) in
                        viewModel.contentMLB = content
                    }
                    viewModel.isPresentContent = true
                    print(model.gamePk)
                } label: {
                    GameFinalView(teams: model.teams, status: model.status)
                }.sheet(isPresented: $viewModel.isPresentContent) {
                    GameContentView(viewModel: self.viewModel, gamePk: model.gamePk)
                }
            case .live:
                Button {
                    viewModel.fetchData(url: URL(string: "https://statsapi.mlb.com/api/v1.1/game/\(model.gamePk)/feed/live?language=es")!, placeholder: ContentResults.default) { (content: ContentResults) in
                        viewModel.contentMLB = content
                    }
                    viewModel.isPresentContent = true
                    print(model.gamePk)
                    
                } label: {
                    GameLiveView(teams: model.teams, linescore: model.linescore, status: model.status)
                }.sheet(isPresented: $viewModel.isPresentContent) {
                    GameContentView(viewModel: self.viewModel, gamePk: model.gamePk)
                }
            case .preview:
                GamePreview(teams: model.teams, status: model.status, games: model)
            case .none:
                EmptyGamesView()
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
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
            ScoreView(awayScore: teams.away.score, homeScore: teams.home.score, status: status.detailedState)
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
    var linescore: Linescore
    var status: Status
    
    var body: some View {
        
        VStack (spacing: 0) {
            HStack {
                TeamView(teamName: "\(teams.away.team.id)", wins: teams.away.leagueRecord.wins, losses: teams.away.leagueRecord.losses)
                ScoreView(awayScore: teams.away.score, homeScore: teams.home.score, status: status.detailedState)
                TeamView(teamName: "\(teams.home.team.id)", wins: teams.home.leagueRecord.wins, losses: teams.home.leagueRecord.losses)
            }
            Divider()
                .foregroundColor(.secondary)
                .padding(.horizontal)
            HStack (alignment: .center, spacing: 10) {
                InningView(arrowStatus: linescore.inningArrowStatus, currentInning: linescore.currentInningOrdinal)
                DiamondView(baseState: linescore.offense.diamondState)
                BSOView(balls: linescore.ballsState, strikes: linescore.strikesState, outs: linescore.outsState)
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
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                    Text(games.gameDate.hourFormat(status: status.startTimeTBD))
                        .font(.title3)
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
        VStack {
            ProgressView()
                .scaleEffect()
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

struct BoxScoreView: View {
    
    var team: Teams
    var linescore: Linescore
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
    
    var linescore: Linescore
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            VStack (alignment: .leading) {
                HStack (spacing: 5) {
                    ForEach(1..<(linescore.getNumberInnings) + 1) { inning in
                        Text("\(inning)")
                            .foregroundColor(.secondary)
                            .modifier(modifierText(frameSize: 15, font: .caption))
                    }
                }
                
                HStack (spacing: 5) {
                    ForEach(linescore.innings) { score in
                        VStack {
                            Text("\(score.away.runs)")
                                .foregroundColor(.primary)
                                .fontWeight((score.away.runs) > 0 ? .bold : .none)
                                .modifier(modifierText(frameSize: 15, font: .caption))
                        Text("\(score.home.runs)")
                            .foregroundColor(.primary)
                            .fontWeight((score.home.runs) > 0 ? .bold : .none)
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
    var linescore: Linescore
    
    var body: some View {
        VStack {
            HStack (spacing: 5) {
                ForEach(0..<header.count) { item in
                    Text(header[item])
                        .foregroundColor(.secondary)
                        .modifier(modifierText(frameSize: 15, font: .caption))
                }
            }
            HStack (spacing: 5) {
                Text("\(linescore.teams.away.runs)")
                    .foregroundColor(.primary)
                    .fontWeight((linescore.teams.away.runs) > 0 ? .bold : .none)
                    .modifier(modifierText(frameSize: 15, font: .caption))
                Text("\(linescore.teams.away.hits)")
                    .foregroundColor(.primary)
                    .fontWeight((linescore.teams.away.hits) > 0 ? .bold : .none)
                    .modifier(modifierText(frameSize: 15, font: .caption))
                Text("\(linescore.teams.away.errors)")
                    .foregroundColor(.primary)
                    .fontWeight((linescore.teams.away.errors) > 0 ? .bold : .none)
                    .modifier(modifierText(frameSize: 15, font: .caption))
            }
            HStack (spacing: 5) {
                Text("\(linescore.teams.home.runs)")
                    .foregroundColor(.primary)
                    .fontWeight((linescore.teams.away.runs) > 0 ? .bold : .none)
                    .modifier(modifierText(frameSize: 15, font: .caption))
                Text("\(linescore.teams.home.hits)")
                    .foregroundColor(.primary)
                    .fontWeight((linescore.teams.away.hits) > 0 ? .bold : .none)
                    .modifier(modifierText(frameSize: 15, font: .caption))
                Text("\(linescore.teams.home.errors)")
                    .foregroundColor(.primary)
                    .fontWeight((linescore.teams.away.errors) > 0 ? .bold : .none)
                    .modifier(modifierText(frameSize: 15, font: .caption))
            }
        }
    }
}

struct ProbablePitcherView: View {
    
    var team: Teams
    
    var body: some View{
        
        HStack {
            PitcherAwayView(pitcher: team.away)
            Spacer()
            PitcherHomeView(pitcher: team.home)
        }.padding()
    }
}


struct PitcherAwayView: View {
    
    var pitcher: TeamData
    
    var body: some View {
        HStack {
            WebImage(url: .imageURL(image: pitcher.probablePitcher.id))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .frame(width: 50, height: 50, alignment: .center)
            ProbablePitcherStatsView(pitcher: pitcher, alignment: .leading)
                .redacted(reason: pitcher.probablePitcher.boxscoreName == "unknown" ? .placeholder : .init())
        }.frame(maxWidth: .infinity)
    }
}

struct PitcherHomeView: View {
    
    var pitcher: TeamData
    
    var body: some View {
        HStack {
            ProbablePitcherStatsView(pitcher: pitcher, alignment: .trailing)
                .redacted(reason: pitcher.probablePitcher.boxscoreName == "unknown" ? .placeholder : .init())
            WebImage(url: .imageURL(image: pitcher.probablePitcher.id))
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
            Text(pitcher.probablePitcher.boxscoreName)
                .font(.caption)
                .foregroundColor(.secondary)
                .fontWeight(.bold)
            Text("\(pitcher.probablePitcher.pitchHand.code.appending("HP")) #\(pitcher.probablePitcher.primaryNumber)")
                .font(.caption)
                .foregroundColor(.secondary)
            ForEach(pitcher.probablePitcher.stats, id: \.id) { stat in
                if stat.group.displayName.contains("pitching") && stat.type.displayName.contains("statsSingleSeason") {
                    Text("\(stat.stats.wins)-\(stat.stats.losses), \(stat.stats.era) ERA")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
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
