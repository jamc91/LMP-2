//
//  VideosView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 03/01/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import AVKit

struct VideosView: View {
    
    let videoData: [Items]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(videoData) { item in
                    VideoCell(item: item)
                        
                }
            }
        }
        .tabItem { Label("Videos", systemImage: "video") }
    }
}

struct VideosView_Previews: PreviewProvider {
    static var previews: some View {
    
            VideosView(videoData: VideoResponse.data.highlights.highlights.items)
        
        .previewLayout(.sizeThatFits)
    }
}

struct VideoCell: View {
    
    let item: Items
    @State private var showVideo = false
    
    var urlVideo: URL {
        var urlString: URL?
        for item in item.playbacks.filter({ $0.name.contains("hlsCloud") }) {
            urlString = item.url
        }
        return urlString!
    }
    
    var avPlayer: AVPlayer {
        let player = AVPlayer(url: urlVideo)
        player.play()
        return player
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ZStack {
                    WebImage(url: item.image.cuts[0].src, isAnimating: .constant(true))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            showVideo = true
                    }
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.headline)
                        .font(.title2)
                    Text("\(item.duration.minuteFormatter()) | \(item.date.dateVideoFormatter())")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(10)
            }
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(10)
            .fullScreenCover(isPresented: $showVideo, content: {
                VideoPlayer(player: avPlayer)
                    .edgesIgnoringSafeArea(.all)
                    .onDisappear {
                        self.showVideo = false
                        avPlayer.replaceCurrentItem(with: nil)
                    }
            })
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color(.systemGroupedBackground))
    }
}