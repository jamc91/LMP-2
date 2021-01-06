//
//  tabBarView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TabBarView: View {

    @ObservedObject var contentViewModel: ContentViewModel
    @Binding var showDatePicker: Bool
    @Binding var presentSheet: Bool
    
    var body: some View {
            TabView {
                MainScrollView {
                    HeaderView(title: "Scoreboard", showCalendarButton: true) {
                        didTapCalendarButton()
                    }
                    ScoreboardView(loadingState: $contentViewModel.loadingState, games: $contentViewModel.scheduledGames) { gamePk in
                        contentViewModel.getLiveContent(gamePk: gamePk) {
                            self.presentSheet = true
                        }
                        contentViewModel.getVideoList(gamePk: gamePk)
                    }
                }
                .tabItem {
                    Label("Scoreboard", systemImage: "mail.stack.fill")
                }
                MainScrollView {
                    StandingView(viewModel: contentViewModel)
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
        TabBarView(
            contentViewModel: ContentViewModel(games: Games.data, standingMLB: StandingMLB.data,
            standingLMP: StandingLMP.data),
            showDatePicker: .constant(false),
            presentSheet: .constant(false))
    }
}

/// Metodos de la vista
extension TabBarView {
    private func didTapCalendarButton() {
        self.showDatePicker = true
        if !contentViewModel.timerStopped {
            contentViewModel.stopTimer()
        }
    }
}
