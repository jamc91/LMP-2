//
//  DetailPreview.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct DetailPreview: View {
    
    let previewData: LiveResponse
    
    var body: some View {
        HStack {
            TeamView(
                teamName: "\(previewData.gameData.teams.away.id)",
                wins: previewData.gameData.teams.away.record.wins,
                losses: previewData.gameData.teams.away.record.losses)
            VStack(spacing: 5) {
                Text(previewData.gameData.teams.away.teamName)
                    .fontWeight(.semibold) +
                Text(" @ ")
                    .foregroundColor(.secondary) +
                Text(previewData.gameData.teams.home.teamName)
                    .fontWeight(.semibold)
                Group {
                    Text(previewData.gameData.datetime.dateTime.hourFormat())
                    Text("\(previewData.gameData.venue.name)•\(previewData.gameData.venue.location.city), \(previewData.gameData.venue.location.stateAbbrev)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
            }
            TeamView(
                teamName: "\(previewData.gameData.teams.home.id)",
                wins: previewData.gameData.teams.home.record.wins,
                losses: previewData.gameData.teams.home.record.losses)
        }
    }
}

struct DetailPreview_Previews: PreviewProvider {
    static var previews: some View {
        DetailPreview(previewData: Constats.shared.live)
            .previewLayout(.sizeThatFits)
    }
}
