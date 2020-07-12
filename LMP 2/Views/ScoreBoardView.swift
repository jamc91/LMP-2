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
        
        if viewModel.showActivityIndicator {
            return HStack (alignment: .center) {
                Spacer()
                ActivityIndicator(showIndicator: $viewModel.showActivityIndicator, style: .medium).foregroundColor(.secondary)
                Text("Cargando")
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding()
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(10)
            .eraseToAnyView()
        } else {
        
          return ForEach(viewModel.games, id: \.id) { item in
                
                scoreBoardView(game: item)
                    
            }.eraseToAnyView()
        }
    }
}

struct ScoreBoardView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ScoreBoardView(viewModel: ViewModel())
            scoreBoardView(game: ScoreBoard(gameStatus: 0, gameTime: "10:34", awayTeam: "NAV", awayRuns: 2, homeTeam: "OBR", homeRuns: 4, diamond: "pos-001", balls: "balls-2", strikes: "strikes-1", outs: "outs-1", inningArrow: "top"))
        }
    }
}
struct headerScoreView: View {
    
    var game: ScoreBoard
    
    var body: some View {
        
        HStack {
            Image(game.homeTeam)
                .resizable()
                .frame(width: 70, height: 70)
                .padding(.leading, 10)
            Spacer()
            gameStatus(status: game.gameStatus)
            Spacer()
            Image(game.awayTeam)
                .resizable()
                .frame(width: 70, height: 70)
                .padding(.trailing, 10)
        }
    }
    
    func gameStatus(status: Int) -> some View {
        switch status {
        case 0:
            return VStack (spacing: 5) {
                
                Text("VS.")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                HStack {
                    Image(systemName: "clock.fill")
                    Text(game.gameTime)
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.primary)
                }
                .padding(5)
                .background(Color(.systemGray6))
                .cornerRadius(5)
            }.eraseToAnyView()
        case 1, 3, 4:
            return Text("\(game.homeRuns)-\(game.awayRuns)")
                .font(.system(size: 50, design: .rounded))
                .eraseToAnyView()
        case 2:
            return VStack {
                Text("\(game.homeRuns)-\(game.awayRuns)")
                .font(.system(size: 50, design: .rounded))
                Text("Finalizado")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.secondary)
                    .padding(5)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
            }.eraseToAnyView()
        case 5, 6, 7:
            return HStack {
                Image(systemName: "exclamationmark.circle.fill")
                    .foregroundColor(Color(.systemRed))
                Text("Cancelado")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(Color(.systemRed))
            }
            .padding(5)
            .background(Color(.systemGray6))
            .cornerRadius(5)
            .eraseToAnyView()
        default:
            return Text("")
            .eraseToAnyView()
        }
    }
    
}
struct footerScoreView: View {
    
    var game: ScoreBoard
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: game.inningArrowStatus)
                    .font(.system(.headline))
                Text(game.inningCurrentOrdinal)
                    .font(.system(size: 20))
            }.frame(width: 80, height: 40, alignment: .trailing)
            Spacer()
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
            }
            Spacer()
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
            }.frame(width: 80, height: 70, alignment: .leading)
        }
    }
}

struct scoreBoardView: View {
    
    var game: ScoreBoard
    
    var body: some View {
        VStack {
            scoreBoardView(status: game.gameStatus, time: game.gameTime)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
    func scoreBoardView(status: Int, time: String) -> some View {
        
        if time == "No Hay Juegos" {
            return HStack {
                
                VStack (alignment: .leading) {
                    
                    Text("No hay juegos.")
                        .foregroundColor(Color(.systemGray))
                    
                }
                Spacer()
            }
            .eraseToAnyView()
        }
        else {
            
            switch status {
            case 1:
                return VStack (spacing: 15){
                    headerScoreView(game: game)
                    Divider()
                    footerScoreView(game: game)
                }
                .eraseToAnyView()
            default:
                return headerScoreView(game: game)
                    .eraseToAnyView()
            }
        }
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
