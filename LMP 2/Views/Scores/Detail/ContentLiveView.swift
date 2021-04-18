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
            switch viewModel.live?.gameData.status.abstractGameState {
            case .live, .final:
                if let boxscoreData = viewModel.live {
                    BoxscoreGameView(live: boxscoreData)
                }
            case .preview:
                if let previewData = viewModel.live {
                    DetailPreview(previewData: previewData)
                }
            case .none:
                Text("No hay informacion.")
            }
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
        .padding()
    }
}
