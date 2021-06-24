//
//  ContentLiveView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 10/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ContentLiveView: View {
    
    @StateObject var liveViewModel: LiveViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(gamePk: Int) {
        self._liveViewModel = StateObject(wrappedValue: LiveViewModel(gamePk: gamePk))
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            dismissButton
            TabView {
                switch liveViewModel.live?.gameData.status.abstractGameState {
                case .live, .final:
                    if let boxscoreData = liveViewModel.live {
                        BoxscoreGameView(live: boxscoreData)
                            .tabItem { Label("Boxscore", systemImage: "list.bullet") }
                    }
                case .preview:
//                    if let previewData = liveViewModel.live {
//                        DetailPreview(previewData: previewData, game: game)
//                            .tabItem { Label("Preview", systemImage: "list.bullet") }
//                    }
                Text("Preview coming soon")
                case .none:
                    Text("No hay informacion.")
                }
                
                if let content = liveViewModel.content, !content.highlights.highlights.items.isEmpty {
                    VideosView(content: content)
                        .tabItem { Label("Videos", systemImage: "video.fill") }
                }
            }
            .accentColor(.black)
        }
        .onDisappear {
            // pendiente detener el timer.
        }
    }
}

struct ContentLiveView_Previews: PreviewProvider {
    static var previews: some View {
        ContentLiveView(gamePk: 0)
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
    
//    var game: Game {
//        guard let index = liveViewModel.games.firstIndex(where: { $0.gamePk == liveViewModel.live!.gamePk }) else { fatalError("Error load gamePk") }
//        return liveViewModel.games[index]
//    }
}

enum BoxscoreSection: String, CaseIterable {
    case boxscore
    case videos
    case plays
}
