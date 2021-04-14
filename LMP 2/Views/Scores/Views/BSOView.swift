//
//  BSOView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct BSOView: View {
    
    @Environment(\.colorScheme) var colorScheme
    let balls: [String]
    let strikes: [String]
    let outs: [String]
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack(spacing: 4) {
                Text("B")
                    .modifier(textModifier(font: .headline, fontColor: Color("LightGray"), fontDesing: .default))
                ForEach(balls, id: \.self) { item in
                    Image(systemName: colorScheme == .light ? item : "circle.fill")
                        .foregroundColor(Color(isActive(status: item)))
                        .font(.system(size: 11))
                }
            }
            HStack(spacing: 4) {
                Text("S")
                    .modifier(textModifier(font: .headline, fontColor: Color("LightGray"), fontDesing: .default))
                ForEach(strikes, id: \.self) { item in
                    Image(systemName: colorScheme == .light ? item : "circle.fill")
                        .foregroundColor(Color(isActive(status: item)))
                        .font(.system(size: 11))
                }
            }
            HStack(spacing: 4) {
                Text("O")
                    .modifier(textModifier(font: .headline, fontColor: Color("LightGray"), fontDesing: .default))
                ForEach(outs, id: \.self) { item in
                    Image(systemName: colorScheme == .light ? item : "circle.fill")
                        .foregroundColor(Color(isActive(status: item)))
                        .font(.system(size: 11))
                }
            }.offset(x: -2, y: 0)
        }.frame(width: 100, height: 100)
    }
    func isActive(status: String) -> String {
        return status == "circle.fill" ? "ActiveColor" : "LightGray"
    }
}


struct BSOView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BSOView(
                balls: ["circle.fill", "circle", "circle", "circle"],
                strikes: ["circle.fill", "circle", "circle"],
                outs: ["circle.fill", "circle", "circle"]).previewLayout(.sizeThatFits)
            BSOView(
                balls: ["circle.fill", "circle", "circle", "circle"],
                strikes: ["circle.fill", "circle", "circle"],
                outs: ["circle.fill", "circle", "circle"]).previewLayout(.sizeThatFits).preferredColorScheme(.dark)
        }
    }
}

struct textModifier: ViewModifier {
    
    var font: Font = .headline
    var fontColor: Color = .primary
    var fontDesing: Font.Design = .rounded
    
    func body(content: Content) -> some View {
        return content
            .font(font)
            .foregroundColor(fontColor)
            
    }
}
