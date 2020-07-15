//
//  ScoreBoardView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScoreBoardView: View {
    
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        Group {
            if viewModel.showActivityIndicator {
                LoadingView(isLoading: $viewModel.showActivityIndicator)
            } else {
                ForEach(viewModel.games) { game in
                    if game.gameStatus == 0 && game.gameTime == "No Hay Juegos" {
                        EmptyGamesView()
                    } else if game.gameStatus == 0 {
                        GameComingSoonView(game: game)
                    } else if game.gameStatus == 1 {
                        GameInProgressView(game: game)
                    } else if game.gameStatus == 2 {
                        GameFinalView(game: game)
                    }
                }
            }
        }
    }
}

struct ScoreBoardView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ScoreBoardView(viewModel: ViewModel())
            GameComingSoonView(game: ScoreBoard(gameStatus: 0, gameTime: "7:30 PM", awayTeam: "NAV", awayRuns: 2, homeTeam: "OBR", homeRuns: 4, diamond: "pos-001", balls: "balls-2", strikes: "strikes-1", outs: "outs-1", inningArrow: "top")).previewLayout(.sizeThatFits)
            GameInProgressView(game: ScoreBoard(gameStatus: 1, gameTime: "7:30 PM", awayTeam: "NAV", awayRuns: 2, homeTeam: "OBR", homeRuns: 4, diamond: "pos-001", balls: "balls-2", strikes: "strikes-1", outs: "outs-1", inningArrow: "top", inningCurrent: "7")).previewLayout(.sizeThatFits)
            GameFinalView(game: ScoreBoard(gameStatus: 2, gameTime: "7:30 PM", awayTeam: "NAV", awayRuns: 2, homeTeam: "OBR", homeRuns: 4, diamond: "pos-001", balls: "balls-2", strikes: "strikes-1", outs: "outs-1", inningArrow: "top", inningCurrent: "7")).previewLayout(.sizeThatFits)
        }
    }
}

//MARK: - Status Game Views

struct GameComingSoonView: View {
    
    var game: ScoreBoard
    
    var body: some View {
        HStack {
            TeamView(teamName: game.awayTeam)
            TimeView(time: game.gameTime)
            TeamView(teamName: game.homeTeam)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct GameInProgressView: View {
    
    var game: ScoreBoard
    
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                TeamView(teamName: game.awayTeam)
                ScoreView(game: game)
                TeamView(teamName: game.homeTeam)
            }
            HStack {
                InningView(game: game)
                DiamondView(game: game)
                BSOView(game: game)
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct GameFinalView: View {
    
    var game: ScoreBoard
    
    var body: some View {
        HStack {
            TeamView(teamName: game.awayTeam)
            ScoreView(game: game)
            TeamView(teamName: game.homeTeam)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct LoadingView: View {
    
    @Binding var isLoading: Bool
    
    var body: some View {
        HStack {
            ActivityIndicator(showIndicator: $isLoading, style: .medium).foregroundColor(.secondary)
            Text("Cargando")
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct EmptyGamesView: View {
    var body: some View {
       HStack {
            Text("No hay juegos")
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

//MARK: - Views

struct TeamView: View {
    
    var teamName: String
    
    var body: some View {
        VStack {
            Image(teamName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75, alignment: .center)
        }.frame(maxWidth: .infinity, minHeight: 120)
    }
}

struct ScoreView: View {
    
    var game: ScoreBoard
    
    var body: some View {
        VStack {
            Text("\(game.awayRuns)-\(game.homeRuns)")
                .font(.system(size: 50, weight: .regular, design: .rounded))
                .bold()
            if game.gameStatus == 2 {
                Text("Final")
                    .font(.system(.caption, design: .rounded))
                    .bold()
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
            }
        }.frame(maxWidth: .infinity, minHeight: 100)
    }
}

struct TimeView: View {
    
    var time: String
    
    var body: some View {
        VStack (spacing: 0) {
            Text("VS.")
                .font(.system(.largeTitle, design: .rounded))
                .bold()
            HStack {
                Image(systemName: "clock")
                    .imageScale(.small)
                    .foregroundColor(.secondary)
                Text(time)
                    .font(.system(.caption, design: .rounded))
                    .bold()
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }.frame(maxWidth: .infinity, minHeight: 100)
    }
}

struct BSOView: View {
    
    var game: ScoreBoard
    
    var body: some View {
        VStack (alignment: .leading, spacing: 2) {
            HStack {
                Text("B")
                    .modifier(textModifier(font: .headline, fontColor: .primary, fontDesing: .default))
                ForEach(game.ballsStatus, id: \.self) { item in
                    Image(systemName: item)
                        .imageScale(.small)
                }
            }
            HStack {
                Text("S")
                    .modifier(textModifier(font: .headline, fontColor: .primary, fontDesing: .default))
                ForEach(game.strikesStatus, id: \.self) { item in
                    Image(systemName: item)
                        .imageScale(.small)
                }
            }
            HStack {
                Text("O")
                    .modifier(textModifier(font: .headline, fontColor: .primary, fontDesing: .default))
                ForEach(game.outsStatus, id: \.self) { item in
                    Image(systemName: item)
                        .imageScale(.small)
                }
            }.offset(x: -2, y: 0)
        }.frame(maxWidth: .infinity, minHeight: 100)
    }
}

struct DiamondView: View {
    
    var game: ScoreBoard
    
    var body: some View {
        ZStack {
            Image(systemName: game.diamondView[2])
                .font(.system(size: 30, weight: .ultraLight))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: 22, y: 10)
            Image(systemName: game.diamondView[1])
                .font(.system(size: 30, weight: .ultraLight))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: 0, y: -12)
            Image(systemName: game.diamondView[0])
                .font(.system(size: 30, weight: .ultraLight))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: -22, y: 10)
        }.frame(maxWidth: .infinity, minHeight: 100)
    }
}

struct InningView: View {
    
    var game: ScoreBoard
    
    var body: some View {
        HStack {
            Image(systemName: game.inningArrowStatus)
                .font(.system(.headline))
            Text(game.inningCurrentOrdinal)
                .font(.system(size: 20))
        }.frame(maxWidth: .infinity, minHeight: 100)
    }
}

struct textModifier: ViewModifier {
    
    @State var font: Font = .headline
    @State var fontColor: Color = .primary
    @State var fontDesing: Font.Design = .rounded
    
    func body(content: Content) -> some View {
        return content
            .font(font)
            .foregroundColor(fontColor)
            
    }
}

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var showIndicator: Bool
    
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .medium)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if showIndicator {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}


