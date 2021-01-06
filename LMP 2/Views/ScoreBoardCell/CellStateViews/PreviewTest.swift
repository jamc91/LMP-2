//
//  PreviewTest.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 01/01/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//
import Foundation
import SwiftUI

struct PreviewTest: View {
    
    let game: Games
    @State private var backgroundColor = Color.clear
    
    let halfScreenWidth = UIScreen.main.bounds.size.width / 1.59
    let halfScreenWidth2 = UIScreen.main.bounds.size.width / 2.69
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading) {
            Text("\(game.teams.away.team.teamName) @ \(game.teams.home.team.teamName)")
                .font(.title2)
                Text(game.venue.name)
                .foregroundColor(.secondary)
            }
            .padding(10)
            ZStack(alignment: .leading) {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: 170))
                    path.addLine(to: CGPoint(x: halfScreenWidth2-20, y: 170))
                    path.addLine(to: CGPoint(x: halfScreenWidth-20, y: 0))
                }
                .fill(setBackgroundColor(img: game.teams.away.team.id))
                .background(setBackgroundColor(img: game.teams.home.team.id))
                .frame(height: 170)
                HStack {
                    HStack {
                        Spacer()
                        Image("\(game.teams.away.team.id)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80, alignment: .center)
                        Spacer()
                    }
                    .frame(height: 170, alignment:  .center)
                    Spacer()
                    HStack {
                        Spacer()
                        Image("\(game.teams.home.team.id)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80, alignment: .center)
                        Spacer()
                    }
                    .frame(height: 170, alignment:  .center)
                }
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.black]), startPoint: .top, endPoint: .bottom)
                    .opacity(0.3)
                    .frame(height: 170)
                Text(game.gameDate.hourFormat(status: game.status.startTimeTBD))
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .bold()
                    .padding(.vertical, 2)
                    .padding(.horizontal, 7)
                    .background(Color(.systemGroupedBackground).opacity(0.7))
                    .cornerRadius(3)
                    .offset(x: 10, y: -65)
            }
            
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
    private func setBackgroundColor(img: Int) -> Color {
        switch img {
        case 673:
            return Color(#colorLiteral(red: 0.0690612942, green: 0.1649987102, blue: 0.3144499958, alpha: 1))
        case 674:
            return Color(#colorLiteral(red: 0, green: 0.2574918866, blue: 0.5735817552, alpha: 1))
        case 675:
            return Color(#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1))
        case 676:
            return Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        case 677:
            return Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        case 678:
            return Color(#colorLiteral(red: 0.7259272933, green: 0.02997417934, blue: 0.1942350566, alpha: 1))
        case 679:
            return Color(#colorLiteral(red: 0.9995016456, green: 0.04192399979, blue: 0.1369658113, alpha: 1))
        case 680:
            return Color(#colorLiteral(red: 0.06312734634, green: 0.1257225871, blue: 0.2669116855, alpha: 1))
        case 5482:
            return Color(#colorLiteral(red: 0.7890422604, green: 0.6764920043, blue: 0.1227677812, alpha: 1))
        case 5483:
            return Color(#colorLiteral(red: 0.06312734634, green: 0.1257225871, blue: 0.2669116855, alpha: 1))
        default:
            return Color.clear
        }
    }
}

struct PreviewTest_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PreviewTest(game: Games.data[3])
        }
        .padding()
        .background(Color(.systemGroupedBackground)).previewLayout(.sizeThatFits)
    }
}
