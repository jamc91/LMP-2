//
//  ScoreBoardView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScoreBoardView: View {
    
    @ObservedObject var scoreBoardData = RowViewModel()
    
    var body: some View {
        
        ForEach(scoreBoardData.Results, id: \.id) { item in
            
            ScoreBoardAllView(game: item)
                    
        }
    }
}

struct ScoreBoardView_Previews: PreviewProvider {
    static var previews: some View {
        
        
            ScoreBoardView(scoreBoardData: RowViewModel())
        
    }
}

struct headerScoreView: View {
    
    var game: Response
    
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
    
    func nameCompleted(names: String) -> String {
        switch names {
        case "NAV":
            return "Navojoa"
        case "OBR":
            return "Obregón"
        case "HER":
            return "Hermosillo"
        case "CUL":
            return "Culiacán"
        case "MOC":
            return "Los Mochis"
        case "MAZ":
            return "Mazatlán"
        case "GSV":
            return "Guasave"
        case "MXC":
            return "Mexicali"
        case "JAL":
            return "Jalisco"
        case "MTY":
            return "Monterrey"
        default:
            return "N/A"
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
    
    var game: Response
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: game.inningArrow == "top" ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    .font(.system(.headline))
                Text(formatNumber(inning: game.inningCurrent))
                    .font(.system(size: 20))
            }.frame(width: 80, height: 40, alignment: .trailing)
            Spacer()
            ZStack {
                Image(systemName: diamondStatus(diamond: game.diamond).2 ? "square.fill" : "square")
                    .font(.system(size: 30, weight: .ultraLight))
                    .rotationEffect(Angle(degrees: 45))
                    .offset(x: 22, y: 10)
                    .foregroundColor(diamondStatus( diamond: game.diamond).2 ? Color(.darkGray) : .secondary)
                Image(systemName: diamondStatus(diamond: game.diamond).1 ? "square.fill" : "square")
                    .font(.system(size: 30, weight: .ultraLight))
                    .rotationEffect(Angle(degrees: 45))
                    .offset(x: 0, y: -12)
                    .foregroundColor(diamondStatus( diamond: game.diamond).1 ? Color(.darkGray) : .secondary)
                Image(systemName: diamondStatus(diamond: game.diamond).0 ? "square.fill" : "square")
                    .font(.system(size: 30, weight: .ultraLight))
                    .rotationEffect(Angle(degrees: 45))
                    .offset(x: -22, y: 10)
                    .foregroundColor(diamondStatus( diamond: game.diamond).0 ? Color(.darkGray) : .secondary)
            }
            Spacer()
            VStack (alignment: .leading, spacing: 2) {
                HStack {
                    Text("B")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Image(systemName: ballsStatus(balls: game.balls).0 ? "circle.fill" : "circle")
                        .font(.system(size: 12, weight: .black, design: .rounded))
                        .foregroundColor(ballsStatus(balls: game.balls).0 ? .primary : .secondary)
                    Image(systemName: ballsStatus(balls: game.balls).1 ? "circle.fill" : "circle")
                        .font(.system(size: 12, weight: .black, design: .rounded))
                        .foregroundColor(ballsStatus(balls: game.balls).1 ? .primary : .secondary)
                    Image(systemName: ballsStatus(balls: game.balls).2 ? "circle.fill" : "circle")
                        .font(.system(size: 12, weight: .black, design: .rounded))
                        .foregroundColor(ballsStatus(balls: game.balls).2 ? .primary : .secondary)
                }
                HStack {
                    Text("S")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Image(systemName: strikesStatus(strikes: game.strikes).0 ? "circle.fill" : "circle")
                        .font(.system(size: 12, weight: .black, design: .rounded))
                        .foregroundColor( strikesStatus(strikes: game.strikes).0 ? .primary : .secondary)
                    Image(systemName: strikesStatus(strikes: game.strikes).1 ? "circle.fill" : "circle")
                        .font(.system(size: 12, weight: .black, design: .rounded))
                        .foregroundColor(strikesStatus(strikes: game.strikes).1 ? .primary : .secondary)
                }
                HStack {
                    Text("O")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Image(systemName: outsStatus(outs: game.outs).0 ? "circle.fill" : "circle")
                        .font(.system(size: 12, weight: .black, design: .rounded))
                        .foregroundColor(outsStatus(outs: game.outs).0 ? .primary : .secondary)
                    Image(systemName: outsStatus(outs: game.outs).1 ? "circle.fill" : "circle")
                        .font(.system(size: 12, weight: .black, design: .rounded))
                        .foregroundColor(outsStatus(outs: game.outs).1 ? .primary : .secondary)
                }.offset(x: -2, y: 0)
            }.frame(width: 80, height: 70, alignment: .leading)
        }
    }
    func formatNumber(inning: String) -> String {
        switch inning {
        case "1":
            return "1ra"
        case "2":
            return "2da"
        case "3":
            return "3ra"
        case "4":
            return "4ta"
        case "5":
            return "5ta"
        case "6":
            return "6ta"
        case "7":
            return "7ma"
        case "8":
            return "8va"
        case "9":
            return "9na"
        case "10":
            return "10ma"
        case "11":
            return "11ma"
        case "12":
            return "12ma"
        case "13":
            return "13ra"
        case "14":
            return "14ta"
        case "15":
            return "15ta"
        case "16":
            return "16ta"
        case "17":
            return "17ma"
        case "18":
            return "18va"
        case "19":
            return "19na"
        default:
            return ""
        }
    }
    func diamondStatus(diamond: String) -> (Bool, Bool, Bool) {
        switch diamond {
        case "pos-001":
            return (false, false, true)
        case "pos-011":
            return (false, true, true)
        case "pos-111":
            return (true, true, true)
        case "pos-100":
            return (true, false, false)
        case "pos-010":
            return (false, true, false)
        case "pos-110":
            return (true, true, false)
        case "pos-101":
            return (true, false, true)
        default:
            return (false, false, false)
        }
    }
    func ballsStatus(balls: String) -> (Bool, Bool, Bool) {
        switch balls {
        case "balls-1":
            return (true, false, false)
        case "balls-2":
            return (true, true, false)
        case "balls-3":
            return (true, true, true)
        default:
            return (false, false, false)
            
        }
    }
    func strikesStatus(strikes: String) -> (Bool, Bool) {
        switch strikes {
        case "strikes-1":
            return (true, false)
        case "strikes-2":
            return (true, true)
        default:
            return (false, false)
            
        }
    }
    func outsStatus(outs: String) -> (Bool, Bool) {
        switch outs {
        case "outs-1":
            return (true, false)
        case "outs-2":
            return (true, true)
        default:
            return (false, false)
            
        }
    }
}

struct ScoreBoardAllView: View {
    
    var game: Response
    
    var body: some View {
        VStack {
            scoreBoardView(status: game.gameStatus, time: game.gameTime)
        }
        .padding()
        .background(Color("BackgroundCell"))
        .cornerRadius(10)
    }
    func scoreBoardView(status: Int, time: String) -> some View {
        
        if time == "No Hay Juegos" {
            return HStack {
                
                VStack (alignment: .leading) {
                    Text("No hay juegos.")
                        .foregroundColor(Color(.systemGray))
                    
                }.padding(.horizontal)
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
