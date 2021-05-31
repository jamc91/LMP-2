//
//  ScoresView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 09/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScoresView: View {
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    var body: some View {
        MainScrollView {
            HeaderView(
                title: "Scores",
                showCalendarButton: true,
                showPicker: contentViewModel.didTapCalendarButton)
            StateView
        }
        .tabItem { Label("Scores", image: "scores") }
        .animation(nil)
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView().environmentObject(ContentViewModel())
    }
}

// MARK: - Variables
extension ScoresView {
    var gamesInDictionaryForLeague: [String: [Game]] {
        Dictionary(grouping: contentViewModel.games, by: { $0.teams.away.team.league.nameLeague })
    }
    
    var leagueGameForKey: [String] {
        gamesInDictionaryForLeague.map { $0.key }.sorted(by: >)
    }
}

// MARK: - Views
extension ScoresView {
    var empty: some View {
        Group {
            Spacer(minLength: UIScreen.main.bounds.height / 3)
            Text("No Scheduled Games.")
                .foregroundColor(.secondary)
        }
    }
    
    var loading: some View {
        Group {
            Spacer(minLength: UIScreen.main.bounds.height / 3)
            ProgressView()
        }
    }
    
    func getGameCell(game: Game) -> some View {
         Group {
            switch game.status.abstractGameState {
            case .live:
                 ScoreLiveCell(game: game)
            case .final:
                 ScoreFinalCell(game: game)
            case .preview:
                 ScorePreviewCell(game: game)
            }
        }
    }
    
    var StateView: some View {
        VStack(alignment: .center, spacing: 10) {
            switch contentViewModel.loadingState {
            case .loading:
                loading
            case .loaded:
                ForEach(leagueGameForKey, id: \.self) { section in
                    Section(header: HeaderSectionView(title: section)) {
                        ForEach(gamesInDictionaryForLeague[section, default: .init()]) { game in
                            getGameCell(game: game)
                                .onTapGesture {
                                    contentViewModel.getLiveContent(gamePk: game.gamePk) {
                                        contentViewModel.showSheet = true
                                        contentViewModel.stopTimer()
                                    }
                                    contentViewModel.getVideoList(gamePk: game.gamePk)
                                }
                                .fullScreenCover(isPresented: $contentViewModel.showSheet, content: {
                                    ContentLiveView(viewModel: contentViewModel)
                                })
                        }
                    }
                }
            case .empty:
                empty
            }
        }
        .padding([.horizontal, .bottom])
    }
}

struct HeaderSectionView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.system(size: 22))
            Spacer()
        }.padding(.top, 10)
    }
}
