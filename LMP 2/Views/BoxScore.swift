//
//  BoxScore.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 16/07/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct BoxScore: View {
    
    var header = ["R", "H", "E"]
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("Mayos")
                .modifier(modifierText(font: .caption))
                Text("Yaquis de obregon")
                .modifier(modifierText(font: .caption))
            }.frame(height: 40, alignment: .bottom)
            
            VStack (alignment: .leading) {
                HStack (spacing: 5) {
                    ForEach(1..<10) { inning in
                        Text("\(inning)")
                            .foregroundColor(.secondary)
                            .modifier(modifierText(frameSize: 15, font: .caption))
                    }
                    
                }
                HStack (spacing: 5) {
                    ForEach(1..<10) { score in
                        VStack {
                            Text("\(score)")
                            .modifier(modifierText(frameSize: 15, font: .caption))
                            Text("\(score)")
                            .modifier(modifierText(frameSize: 15, font: .caption))
                        }
                    }
                }
            }
            VStack {
                HStack (spacing: 5) {
                    ForEach(0..<header.count) { item in
                        Text(self.header[item]).foregroundColor(.secondary)
                           .modifier(modifierText(frameSize: 15, font: .caption))
                    }
                }
                HStack (spacing: 5) {
                    Text("2")
                        .modifier(modifierText(frameSize: 15, font: .caption))
                    Text("14")
                        .modifier(modifierText(frameSize: 15, font: .caption))
                    Text("17")
                        .modifier(modifierText(frameSize: 15, font: .caption))
                }
                HStack (spacing: 5) {
                    Text("4")
                        .modifier(modifierText(frameSize: 15, font: .caption))
                    Text("13")
                        .modifier(modifierText(frameSize: 15, font: .caption))
                    Text("22")
                        .modifier(modifierText(frameSize: 15, font: .caption))
                }
            }
        }
    }
}

struct BoxScore_Previews: PreviewProvider {
    static var previews: some View {
        BoxScore()
    }
}
