//
//  PersonView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/18/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct PersonView: View {
    
    enum PositionPlayer {
        case left, right
    }
    
    let imageID: Int
    let personName: String
    let primaryNumber: String
    let pitchHand: String
    let stats: StatsContent
    let position: PositionPlayer
    
    var image: some View {
        WebImage(url: EndPoint.image(imageID).urlRequest.url)
            .resizable()
            .placeholder(Image("default-player"))
            .scaledToFit()
            .background(Color(.systemGray5))
            .clipShape(Circle())
            .frame(width: 60, height: 60)
            .unredacted()
    }
    
    var body: some View {
        HStack {
            if position == .left {
                image
            }
            VStack(alignment: position == .left ? .leading : .trailing) {
                Text(personName)
                    .foregroundColor(.primary)
                    .bold()
                Text("\(pitchHand)HP #\(primaryNumber)")
                Text("\(stats.wins)-\(stats.losses), \(stats.era) ERA")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            if position == .right {
                image
            }
        }
        .redacted(reason: personName == "unknown" ? .placeholder : .init())
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonView(imageID: 0, personName: "Valdez, F", primaryNumber: "59", pitchHand: "L", stats: StatsContent(), position: .left).previewLayout(.sizeThatFits)
            PersonView(imageID: 0, personName: "unknown", primaryNumber: "59", pitchHand: "L", stats: StatsContent(), position: .left).previewLayout(.sizeThatFits)
            PersonView(imageID: 0, personName: "Valdez, F", primaryNumber: "59", pitchHand: "L", stats: StatsContent(), position: .right).previewLayout(.sizeThatFits).preferredColorScheme(.dark)
            PersonView(imageID: 0, personName: "unknown", primaryNumber: "59", pitchHand: "L", stats: StatsContent(), position: .right).previewLayout(.sizeThatFits).preferredColorScheme(.dark)
        }
    }
}
