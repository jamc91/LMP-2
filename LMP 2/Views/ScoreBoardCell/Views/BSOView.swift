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
    var balls: [String]
    var strikes: [String]
    var outs: [String]
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("B")
                    .modifier(textModifier(font: .title3, fontColor: Color("LightGray"), fontDesing: .default))
                ForEach(balls, id: \.self) { item in
                    Image(systemName: colorScheme == .light ? item : "circle.fill")
                        .foregroundColor(Color(isActive(status: item)))
                        .font(.system(size: 12))
                }
            }
            HStack {
                Text("S")
                    .modifier(textModifier(font: .title3, fontColor: Color("LightGray"), fontDesing: .default))
                ForEach(strikes, id: \.self) { item in
                    Image(systemName: colorScheme == .light ? item : "circle.fill")
                        .foregroundColor(Color(isActive(status: item)))
                        .font(.system(size: 12))
                }
            }
            HStack {
                Text("O")
                    .modifier(textModifier(font: .title3, fontColor: Color("LightGray"), fontDesing: .default))
                ForEach(outs, id: \.self) { item in
                    Image(systemName: colorScheme == .light ? item : "circle.fill")
                        .foregroundColor(Color(isActive(status: item)))
                        .font(.system(size: 12))
                }
            }.offset(x: -2, y: 0)
        }.frame(width: 100, height: 100, alignment: .center)
    }
    func isActive(status: String) -> String {
        return status == "circle.fill" ? "ActiveColor" : "LightGray"
    }
}


struct BSOView_Previews: PreviewProvider {
    static var previews: some View {
        BSOView(balls: ["circle.fill", "circle", "circle"], strikes: ["circle.fill", "circle"], outs: ["circle.fill", "circle"]).previewLayout(.sizeThatFits)
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
