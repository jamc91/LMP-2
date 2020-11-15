//
//  ScoreBoardView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScoreBoardView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var showContent = false
    var body: some View {
        VStack (spacing: 10) {
            TopHeaderView(viewModel: viewModel, title: "Scoreboards", showCalendarButton: true)
                .padding(.bottom, 10)
            switch viewModel.loadingState {
            case .loading:
                LoadingView()
            case .loaded:
                if !viewModel.games.filter { $0.teams.away.team.sport.id == 17 }.isEmpty {
                    Section(header: HeaderSectionView(title: "Mexican Pacific League")) {
                        ForEach(viewModel.games.filter { $0.teams.away.team.sport.id == 17 }) { game in
                            ScoreRowView(gameModel: game, showContent: $showContent)
                                .background(Color(.secondarySystemGroupedBackground))
                                .cornerRadius(10)
                                .onTapGesture {
                                    viewModel.fetchData(url: URL(string: "https://statsapi.mlb.com/api/v1.1/game/\(game.gamePk)/feed/live")!) { (game: ContentResults) in
                                        self.viewModel.contentMLB = game
                                        self.showContent = true
                                    }
                                }
                                .sheet(isPresented: $showContent, content: {
                                    GameContentView(viewModel: viewModel)
                                })
                                .alert(isPresented: $viewModel.showingAlert) {
                                    Alert(title: Text("Error"), message: Text("Ha ocurrido un error al descargar la informacion"), dismissButton: .cancel(Text("OK")))
                                }
                        }
                    }
                }
                if !viewModel.games.filter { $0.teams.away.team.sport.id == 1 }.isEmpty {
                    Section(header: HeaderSectionView(title: "Major League Baseball")) {
                        ForEach(viewModel.games.filter { $0.teams.away.team.sport.id == 1 }) { game in
                            ScoreRowView(gameModel: game, showContent: $showContent)
                                .background(Color(.secondarySystemGroupedBackground))
                                .cornerRadius(10)
                                .onTapGesture {
                                    viewModel.fetchData(url: URL(string: "https://statsapi.mlb.com/api/v1.1/game/\(game.gamePk)/feed/live")!) { (game: ContentResults) in
                                        self.viewModel.contentMLB = game
                                        self.showContent = true
                                    }
                                }
                                .sheet(isPresented: $showContent, content: {
                                    GameContentView(viewModel: viewModel)
                                })
                        }
                    }
                }
                
            case .empty:
                EmptyGamesView()
            }
        }
        .padding([.horizontal, .bottom], 20)
    }
}
struct ScoreBoardView_Previews: PreviewProvider {
    static var previews: some View {
        
            ScoreBoardView(viewModel: ViewModel())
    }
}

//MARK: - Status Game Views

struct ScoreRowView: View {
    
    var gameModel: Games
    @Binding var showContent: Bool
    
    var body: some View {
        switch GameState(rawValue: gameModel.status.abstractGameState) {
        case .live:
            GameLiveView(gameModel: gameModel)
        case .final:
            GameFinalView(gameModel: gameModel)
        case .preview:
            GamePreview(gameModel: gameModel)
        case .none:
            EmptyGamesView()
        }
    }
}

struct GameFinalView: View {
    
    var gameModel: Games
    
    var body: some View {
        VStack {
            HStack {
                TeamView(teamName: "\(gameModel.teams.away.team.id)",
                         wins: gameModel.teams.away.leagueRecord.wins,
                         losses: gameModel.teams.away.leagueRecord.losses)
                ScoreView(awayScore: gameModel.teams.away.score,
                          homeScore: gameModel.teams.home.score,
                          status: gameModel.status.detailedState)
                TeamView(teamName: "\(gameModel.teams.home.team.id)",
                         wins: gameModel.teams.home.leagueRecord.wins,
                         losses: gameModel.teams.home.leagueRecord.losses)
            }
            Divider().padding(.horizontal).foregroundColor(.secondary)
            ProbablePitcherView(player1: gameModel.decisions.winner, player2: gameModel.decisions.loser)
        }
    }
}

struct GameLiveView: View {
    
    var gameModel: Games
    
    var body: some View {
        
        VStack (spacing: 0) {
            HStack {
                TeamView(teamName: "\(gameModel.teams.away.team.id)",
                         wins: gameModel.teams.away.leagueRecord.wins,
                         losses: gameModel.teams.away.leagueRecord.losses)
                ScoreView(awayScore: gameModel.teams.away.score,
                          homeScore: gameModel.teams.home.score,
                          status: gameModel.status.detailedState)
                TeamView(teamName: "\(gameModel.teams.home.team.id)",
                         wins: gameModel.teams.home.leagueRecord.wins,
                         losses: gameModel.teams.home.leagueRecord.losses)
            }
            Divider()
                .foregroundColor(.secondary)
                .padding(.horizontal)
            HStack (alignment: .center, spacing: 10) {
                InningView(arrowStatus: gameModel.linescore.inningArrowStatus,
                           currentInning: gameModel.linescore.currentInningOrdinal)
                DiamondView(baseState: gameModel.linescore.offense.diamondState)
                BSOView(balls: gameModel.linescore.ballsState,
                        strikes: gameModel.linescore.strikesState,
                        outs: gameModel.linescore.outsState)
            }
        }
    }
}

struct GamePreview: View {
    
    var gameModel: Games
    
    var body: some View {
        VStack (spacing: 0){
            HStack {
                TeamView(teamName: "\(gameModel.teams.away.team.id)",
                         wins: gameModel.teams.away.leagueRecord.wins,
                         losses: gameModel.teams.away.leagueRecord.losses)
                VStack {
                    Text("VS.")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                    Text(gameModel.gameDate.hourFormat(status: gameModel.status.startTimeTBD))
                        .font(.title3)
                }
                TeamView(teamName: "\(gameModel.teams.home.team.id)",
                         wins: gameModel.teams.home.leagueRecord.wins,
                         losses: gameModel.teams.home.leagueRecord.losses)
            }
            Divider().padding(.horizontal)
            ProbablePitcherView(player1: gameModel.teams.away.probablePitcher, player2: gameModel.teams.home.probablePitcher)
        }
    }
}


struct LoadingView: View {
    
    var body: some View {
        Spacer(minLength: UIScreen.main.bounds.height / 3)
        VStack {
            ProgressView()
        }
    }
}

struct EmptyGamesView: View {
    var body: some View {
        Spacer(minLength: UIScreen.main.bounds.height / 3.5)
        VStack (spacing: 5) {
            Image("batsgray")
                .resizable()
                .frame(width: 65, height: 65, alignment: .center)
            Text("No hay juegos programados.")
                .foregroundColor(.secondary)
        }
    }
}
