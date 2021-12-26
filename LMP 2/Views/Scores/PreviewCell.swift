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
                HStack {
                    Image(String(game.teams.away.team.id))
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width / 2, height: 80)
                    Spacer()
                    Image(String(game.teams.home.team.id))
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width / 2, height: 80)
                }
                .frame(height: 180)
                .background(TeamBackgroundShape().fill(getBackgroundColor(teamId: game.teams.home.team.id)))
                .background(getBackgroundColor(teamId: game.teams.away.team.id))
                .overlay(alignment: .topLeading) {
                    Text(game.gameDate, style: .time)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.secondary)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 5)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                        .padding(10)
                }
            }
            .frame(height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 7.0))
            VStack(alignment: .leading, spacing: 4) {
                Text(game.venue.name)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.blue)
                Text("\(game.teams.away.team.name) at \(game.teams.home.team.name)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(height: 55)
            }
        }
    }
    
    func getBackgroundColor(teamId: Int) -> Color {
        switch teamId {
        case 680:
            return Color("blue")
        case 5482:
            return Color("brown")
        case 5483:
            return Color("darkBlue")
        case 677:
            return Color("Orange")
        case 678:
            return Color("cayenne")
        case 676:
            return Color("red")
        case 673:
            return Color("red")
        case 674:
            return Color("blue")
        default:
            return Color.white
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
        path.move(to: CGPoint(x: rect.midX-55, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX+55, y: rect.minY))
        return path
    }
}
