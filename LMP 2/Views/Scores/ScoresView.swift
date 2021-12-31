//
//  ScoresView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 09/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScoresView: View {
    
    @EnvironmentObject var scoresViewModel: ScoresViewModel
    @State private var game: Game?
    @State private var showBoxscore = false
    let didTapCalendarButton: () -> Void
    
    var body: some View {
            List {
                HeaderView(
                    title: "Scoreboard",
                    showCalendarButton: true,
                    showPicker: didTapCalendarButton)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                ForEach(leagueGameForKey, id: \.self) { section in
                    Section(header: Text(section)) {
                        ForEach(gamesInDictionaryForLeague[section, default: .init()]) { game in
                            getGameCell(game: game)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                .onTapGesture {
                                    self.game = game
                            }
                        }
                    }
                    .headerProminence(.increased)
                    .listRowInsets(EdgeInsets())
                }
            }
            .id(UUID())
            .padding(.top, 1)
            .background(Color(.systemGroupedBackground))
            .overlay {
                if scoresViewModel.loadingState == .loading {
                    loading
                } else if scoresViewModel.loadingState == .empty {
                    empty
                }
            }
            .refreshable {
                scoresViewModel.refreshScores()
            }
            .sheet(item: $game) { game in
                NavigationView {
                    ContentLiveView(game: game)
                }
            }
            .tabItem { Label("Scoreboard", systemImage: "lanyardcard") }
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView(didTapCalendarButton: {})
            .preferredColorScheme(.dark)
            .environmentObject(ScoresViewModel())
    }
}

// MARK: - Variables
extension ScoresView {
    var gamesInDictionaryForLeague: [String: [Game]] {
        Dictionary(grouping: scoresViewModel.games, by: { $0.teams.away.team.league.nameLeague })
    }
    
    var leagueGameForKey: [String] {
        gamesInDictionaryForLeague.map { $0.key }.sorted(by: >)
    }
}

// MARK: - Views
extension ScoresView {
    /// VISTA VACIA.
    var empty: some View {
        Group {
            Spacer(minLength: UIScreen.main.bounds.height / 3)
            VStack(spacing: 5) {
                Text("No Scheduled Games")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Please try another date.")
                    .foregroundColor(.secondary)
            }
        }
    }
    /// VISTA DE CARGA.
    var loading: some View {
        Group {
            Spacer(minLength: UIScreen.main.bounds.height / 3)
            VStack(spacing: 5) {
                ProgressView()
                Text("LOADING")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    /// VISTA DE CELDA SEGUN EL ESTADO DEL JUEGO.
    @ViewBuilder
    func getGameCell(game: Game) -> some View {
        switch game.status.abstractGameState {
        case .live:
            ScoreLiveCell(game: game)
        case .final:
            ScoreFinalCell(game: game)
        case .preview:
            PreviewCell(game: game)
        }
    }
}
