//
//  ScoreboardViewList.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 23/06/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScoreboardViewList: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    @State private var dealt = Set<Int>()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.games) { game in
                    ScoreLiveCell(game: game)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .onAppear {
            for game in viewModel.games {
                withAnimation(createAnimation(game: game)) {
                    deal(game)
                }
            }
        }
    }
    
    private func createAnimation(game: Game) -> Animation {
        var delay = 0.0
        if let index = viewModel.games.firstIndex(where: { $0.id == game.id }) {
            delay = Double(index) * (2.0 / Double(viewModel.games.count))
        }
        return Animation.spring().delay(delay)
    }
    
    private func deal(_ game: Game) {
        dealt.insert(game.gamePk)
    }

    private func isUnDealt(game: Game) -> Bool {
        dealt.contains(game.gamePk)
    }
}

struct ScoreboardViewList_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardViewList()
            .environmentObject(ContentViewModel(games: Constats.shared.games.dates.first!.games, posts: []))
    }
}
