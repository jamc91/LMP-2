//
//  ScoreboardView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScoreboardView: View {
    
    @Binding var loadingState: ScoreboardLoadingState
    @Binding var games: [Games]
    let fetchLiveData: (Int) -> Void
    
    var gamesInDictionaryForLeague: [Int: [Games]] {
        Dictionary(grouping: games, by: { $0.teams.away.team.league.sortedLeague })
    }
    
    var leagueGameForKey: [Int] {
        gamesInDictionaryForLeague.map { $0.key }.sorted(by: >)
    }
    
    var body: some View {
        LazyVStack (spacing: 10) {
            switch loadingState {
            case .loading:
                LoadingView()
            case .loaded:
                ForEach(leagueGameForKey, id: \.self) { league in
                    Section(header: HeaderSectionView(title: setSectionTitle(league: league))) {
                        ForEach(gamesInDictionaryForLeague[league] ?? []) { game in
                            ScoreRowView(gameModel: game)
                                .onTapGesture {
                                    switch game.status.abstractGameState {
                                    case .live, .final:
                                        fetchLiveData(game.gamePk)
                                    case .preview:
                                        break
                                    }
                                }
                            }
                        }
                    }
            case .empty:
                EmptyGamesView()
            }
        }
        .padding([.horizontal, .bottom], 20)
    }
    private func setSectionTitle(league: Int) -> String {
        switch league {
        case 103, 104:
            return "Major League Baseball"
        case 132:
            return "Mexican Pacific League"
        case 162:
            return "Caribbean Series"
        default:
            return "Liga Desconocida"
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ScrollView {
                ScoreboardView(loadingState: .constant(.loaded), games: .constant(Games.data), fetchLiveData: {_ in })
            }
        }.background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

//MARK: - Status Game Views

struct ScoreRowView: View {
    
    var gameModel: Games
    
    var body: some View {
        VStack {
            switch gameModel.status.abstractGameState {
            case .live:
                ScoreLiveCell(game: gameModel)
            case .final:
                ScoreFinalCell(game: gameModel)
            case .preview:
                PreviewTest(game: gameModel)
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct LoadingView: View {
    
    var body: some View {
        Spacer(minLength: UIScreen.main.bounds.height / 3)
        ProgressView()
    }
}

struct EmptyGamesView: View {
    var body: some View {
        Spacer(minLength: UIScreen.main.bounds.height / 3)
        Text("No Scheduled Games.")
            .foregroundColor(.secondary)
    }
}
