//
//  ProbablePitcherView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 01/11/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProbablePitcherView: View {
    
    var player1: ProbablePitcher
    var player2: ProbablePitcher
    
    var body: some View {
        HStack {
            PlayerView(alignment: .leading, playerPosition: .left, pitcher: player1)
            Spacer()
            PlayerView(alignment: .trailing, playerPosition: .right, pitcher: player2)
        }
        .padding(.horizontal)
        .padding()
    }
}

struct ProbablePitcherView_Previews: PreviewProvider {
    static var previews: some View {
        ProbablePitcherView(player1: ProbablePitcher(), player2: ProbablePitcher()).previewLayout(.sizeThatFits)
    }
}

struct PlayerView: View {
    
    enum Position {
        case left, right
    }
    
    var alignment: HorizontalAlignment
    var playerPosition: Position
    var pitcher: ProbablePitcher
    
    var body: some View {
        HStack {
            if playerPosition == .left {
                PlayerImageView(pitcherImage: pitcher)
            }
            PlayerInfoView(alignment: alignment, pitcher: pitcher)
                
            if playerPosition == .right {
                PlayerImageView(pitcherImage: pitcher)
                
            }
        }
    }
}


struct PlayerImageView: View {
    
    var pitcherImage: ProbablePitcher
    
    var body: some View {
        WebImage(url: .imageURL(image: pitcherImage.id))
            .resizable()
            .placeholder(Image("default-player"))
            .aspectRatio(contentMode: .fill)
            .background(Color(.systemGray5))
            .frame(width: 50, height: 50, alignment: .center)
            .clipShape(Circle())
    }
}

struct PlayerInfoView: View {
    
    var alignment: HorizontalAlignment
    var pitcher: ProbablePitcher
    
    var body: some View {
        VStack (alignment: alignment) {
            Text(pitcher.boxscoreName)
                .font(.caption)
                .bold()
            Text("\(pitcher.pitchHand.code.appending("HP"))#\(pitcher.primaryNumber)")
                .foregroundColor(.secondary)
                .font(.caption)
            ForEach(pitcher.stats) { stat in
                if stat.group.displayName.contains("pitching") && stat.type.displayName.contains("statsSingleSeason") {
                    Text("\(stat.stats.wins)-\(stat.stats.losses), \(stat.stats.era) ERA")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }.redacted(reason: pitcher.boxscoreName == "unknown" ? .placeholder : .init())
    }
}
