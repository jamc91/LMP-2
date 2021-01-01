//
//  tabBarView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TabBarView: View {

    @Binding var games: [Games]
    @Binding var loadingState: ScoreboardLoadingState
    @Binding var showDatePicker: Bool
    let fetchLiveData: (Int) -> Void
    let didTapCalendarButton: () -> Void
    
    var body: some View {
            TabView {
                MainScrollView(content: {
                    HeaderView(title: "Scoreboard", showCalendarButton: true) {
                        self.showDatePicker = true
                        didTapCalendarButton()
                    }
                    ScoreboardView(loadingState: $loadingState, games: $games) { gamePk in
                        fetchLiveData(gamePk)
                    }
                })
                .tabItem {
                    Label("Scoreboard", systemImage: "mail.stack.fill")
                }
                MainScrollView {
                 //   StandingView(viewModel: viewModel)
                }
                .tabItem {
                    Label("Standings", systemImage: "flag.fill")
                }
            }
            .blur(radius: showDatePicker ? 8.0 : 0.0)
    }
}

struct TabBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        TabBarView(games: .constant(Games.data), loadingState: .constant(.loaded), showDatePicker: .constant(false), fetchLiveData: {_ in }, didTapCalendarButton: {})
    }
}


