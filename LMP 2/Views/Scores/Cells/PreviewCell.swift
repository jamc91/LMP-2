//
//  PreviewCell.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 25/12/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct PreviewCell: View {
    
    let game: Game
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    Image(String(game.teams.away.team.id))
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width / 2, height: proxy.size.height / 2.2)
                    Image(String(game.teams.home.team.id))
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width / 2, height: proxy.size.height / 2.2)
                }
                .frame(maxHeight: .infinity)
                .background(TeamBackgroundShape().fill(game.teams.home.team.teamBackgroundColor))
                .background(game.teams.away.team.teamBackgroundColor)
                .overlay(alignment: .topLeading) {
                    Text(game.gameDate.timePM)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.secondary)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 5)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        .padding(10)
                }
            }
            .frame(height: 170)
            .clipShape(RoundedRectangle(cornerRadius: 7.0))
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(game.venue.name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                Text("\(game.teams.away.team.name) at \(game.teams.home.team.name)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .frame(height: 55)
            }
        }
    }
}

struct PreviewCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PreviewCell(game: Constats.shared.games.dates.first!.games[0])
                .previewLayout(.sizeThatFits)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .previewLayout(.sizeThatFits)
    }
}

struct TeamBackgroundShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX / 1.2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX * 1.2, y: rect.minY))
        return path
    }
}
