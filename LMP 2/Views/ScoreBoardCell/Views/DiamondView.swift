//
//  DiamondView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct DiamondView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var baseState: [(image: String, color: String)]
    
    var body: some View {
        ZStack {
            Image(systemName: (colorScheme == .light ? baseState[0].image : "squareshape.fill"))
                .foregroundColor(Color(baseState[0].color))
                .font(.system(size: 30, weight: .thin))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: 22, y: 10)
            Image(systemName: (colorScheme == .light ? baseState[1].image : "squareshape.fill"))
                .foregroundColor(Color(baseState[1].color))
                .font(.system(size: 30, weight: .thin))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: 0, y: -12)
            Image(systemName: (colorScheme == .light ? baseState[2].image : "squareshape.fill"))
                .foregroundColor(Color(baseState[2].color))
                .font(.system(size: 30, weight: .thin))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: -22, y: 10)
        }
        .frame(width: 100, height: 100, alignment: .center)
    }
}

struct DiamondView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DiamondView(baseState: [("squareshape", "LightGray"), ("squareshape", "LightGray"), ("squareshape", "LightGray")]).previewLayout(.sizeThatFits)
            DiamondView(baseState: [("squareshape", "ActiveColor"), ("squareshape", "ActiveColor"), ("squareshape", "ActiveColor")]).previewLayout(.sizeThatFits).preferredColorScheme(.dark)
        }
    }
}
