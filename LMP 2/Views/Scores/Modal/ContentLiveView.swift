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
                if let liveContent = viewModel.live {
                    BoxscoreGameView(live: liveContent)
                }
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
