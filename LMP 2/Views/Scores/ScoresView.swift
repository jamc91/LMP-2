//
//  ScoresView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 09/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import Combine

struct ScoresView: View {
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    @State private var dealt = Set<Int>()
    @State private var game: Game? = nil
    
    var body: some View {
        MainScrollView {
            HeaderView(
                title: "Scores",
                showCalendarButton: true,
                showPicker: contentViewModel.didTapCalendarButton)
            StateView
        }
        .fullScreenCover(isPresented: $contentViewModel.showSheet, content: {
            ContentLiveView(game: game)
        })
        .tabItem { Label("Scores", systemImage: "newspaper.fill") }
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
    
    @ViewBuilder
    func getGameCell(game: Game) -> some View {
        switch game.status.abstractGameState {
        case .live:
            ScoreLiveCell(game: game)
        case .final:
            ScoreFinalCell(game: game)
        case .preview:
            ScorePreviewCell(game: game)
        }
    }
    
    private func dealAnimation(game: Game) -> Animation {
        var delay = 0.0
        if let index = contentViewModel.games.firstIndex(where: { $0.gamePk == game.gamePk }) {
            delay = Double(index) * 0.2
        }
        return Animation.spring().delay(delay)
    }
    
    private func deal(_ game: Game) {
        
        dealt.insert(game.gamePk)
    }

    private func isUnDealt(game: Game) -> Bool {
        dealt.contains(game.gamePk)
    }
    
    private func chooseGame(_ game: Game) -> Int {
        guard let index = contentViewModel.games.firstIndex(where: { $0.id == game.id }) else { return 0 }
        return contentViewModel.games[index].gamePk
    }
    
    var StateView: some View {
            VStack(alignment: .center, spacing: 10) {
                switch contentViewModel.loadingState {
                case .loading:
                    loading
                        .onAppear {
                            dealt.removeAll()
                        }
                case .loaded:
                    ForEach(leagueGameForKey, id: \.self) { section in
                        Section(header: HeaderSectionView(title: section)) {
                            ForEach(gamesInDictionaryForLeague[section, default: .init()].filter(isUnDealt)) { game in
                                getGameCell(game: game)
                                    .onTapGesture {
                                        self.game = game
                                        contentViewModel.showSheet = true
                                        contentViewModel.stopTimer()
                                    }
                                    
                            }
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                    .onAppear {
                        for game in contentViewModel.games {
                            withAnimation(dealAnimation(game: game)) {
                                deal(game)
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
