//
//  ContentLiveView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 10/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ContentLiveView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .trailing) {
            dismissButton
            TabView {
                switch viewModel.live?.gameData.status.abstractGameState {
                case .live, .final:
                    if let boxscoreData = viewModel.live {
                        BoxscoreGameView(live: boxscoreData)
                            .tabItem { Label("Boxscore", systemImage: "list.bullet") }
                    }
                case .preview:
                    if let previewData = viewModel.live {
                        DetailPreview(previewData: previewData, game: game)
                            .tabItem { Label("Preview", systemImage: "list.bullet") }
                    }
                case .none:
                    Text("No hay informacion.")
                }
                
                if let content = viewModel.content, !content.highlights.highlights.items.isEmpty {
                    VideosView(content: content)
                        .tabItem { Label("Videos", systemImage: "video.fill") }
                }
            }
            .accentColor(.black)
        }
        .onDisappear {
            viewModel.live = nil
            viewModel.content = nil
            viewModel.startTimer()
        }
    }
}

struct ContentLiveView_Previews: PreviewProvider {
    static var previews: some View {
        ContentLiveView(viewModel: ContentViewModel(liveContent: Constats.shared.live, videoList: Constats.shared.content))
    }
}

extension ContentLiveView {
    var dismissButton: some View {
        Button(action:  { presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 25))
                .foregroundColor(.secondary)     
        }
        .frame(width: 60)
    }
    
    var game: Game {
        guard let index = viewModel.scheduledGames.firstIndex(where: { $0.gamePk == viewModel.live!.gamePk }) else { fatalError("Error load gamePk") }
        return viewModel.scheduledGames[index]
    }
}

enum BoxscoreSection: String, CaseIterable {
    case boxscore
    case videos
    case plays
}
