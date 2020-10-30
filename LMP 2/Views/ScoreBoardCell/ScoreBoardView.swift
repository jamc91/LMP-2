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
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack (spacing: 10) {
            TopHeaderView(viewModel: viewModel, title: "Scoreboards", showCalendarButton: true)
                .padding(.bottom, 10)
            switch viewModel.loadingState {
            case .loading:
                LoadingView()
            case .loaded:
                Section(header: HeaderSectionView(title: "Mexican Pacific League")) {
                    ForEach(viewModel.games) { game in
                        ScoreboardRow(gameModel: game)
                            .background(Color(.secondarySystemGroupedBackground))
                            .cornerRadius(10)
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

struct ScoreboardRow: View {
    
    var gameModel: Games
    
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
            ProbablePitcherView(team: gameModel.teams)
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
        Spacer(minLength: UIScreen.main.bounds.height / 3)
        HStack (spacing: 5) {
            Text("No hay juegos programados.")
                .foregroundColor(.secondary)
        }
    }
}

//MARK: - Views


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
            ForEach(pitcher.probablePitcher.stats) { stat in
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
