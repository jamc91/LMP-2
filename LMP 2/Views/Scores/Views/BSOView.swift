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
    let balls: Int
    let strikes: Int
    let outs: Int
    
    var body: some View {
        VStack (alignment: .leading) {
            LabelDots(label: "B", numberOfDots: 4, state: balls)
            LabelDots(label: "S", numberOfDots: 3, state: strikes)
            LabelDots(label: "O", numberOfDots: 3, state: outs)
                .offset(x: -2, y: 0)
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
                balls: 1,
                strikes: 2,
                outs: 1).previewLayout(.sizeThatFits)
            BSOView(
                balls: 1,
                strikes: 2,
                outs: 1).previewLayout(.sizeThatFits).preferredColorScheme(.dark)
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


struct LabelDots: View {
    
    @Environment(\.colorScheme) var colorScheme
    let label: String
    let numberOfDots: Int
    let state: Int
    
    var body: some View {
        HStack(spacing: 2) {
            Text(label)
                .font(.headline)
                .foregroundColor(colorScheme == .light ? .primary : Color("LightGray"))
            ForEach(0..<numberOfDots) { index in
                Image(systemName: index < state ? "circle.fill" : "circle")
                    .font(.system(size: 11))
                    .foregroundColor((index < state || colorScheme == .light) ? Color("ActiveColor") : Color("LightGray") )
            }
        }
        
    }
}
