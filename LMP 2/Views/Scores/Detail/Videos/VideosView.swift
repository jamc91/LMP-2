//
//  VideosView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 25/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import AVKit

struct VideosView: View {
    
    var content: ContentResponse
    
    var body: some View {
        List {
            ForEach(content.highlights.highlights.items) { item in
                VideoRow(item: item)
            }
        }
    }
}

struct VideosView_Previews: PreviewProvider {
    static var previews: some View {
        VideosView(content: Constats.shared.content)
    }
}

struct VideoRow: View {
    
    @State private var showVideo = false
    var item: Items
    
    var urlVideo: URL? {
        let url = item.playbacks.filter { $0.name.contains("hlsCloud") }
        return url.first?.url
    }
    
    var player: AVPlayer {
        let player = AVPlayer(url: urlVideo ?? URL(string: "")!)
        player.play()
        return player
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageUrl = item.image.cuts.filter { $0.height == 224 }.first?.src {
                WebImage(url: imageUrl)
                    .resizable()
                    .placeholder {
                        RoundedRectangle(cornerRadius: 15.0, style: .continuous).foregroundColor(Color(.systemGray5))
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .mask(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                    .frame(height: 224)
            }
            VStack(alignment: .leading) {
                Text(item.headline)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("\(item.duration.minuteFormatter()) | \(item.date.dateVideoFormatter())")
                    .foregroundColor(.secondary)
                
            }
        }
        .onTapGesture {
            self.showVideo = true
        }
        .fullScreenCover(isPresented: $showVideo, content: {
            VideoPlayer(player: player)
                .ignoresSafeArea()
                .onDisappear {
                    self.showVideo = false
                    player.replaceCurrentItem(with: nil)
                }
        })
    }
}
