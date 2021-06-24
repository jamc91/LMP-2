//
//  RowStanding.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 05/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct RowStanding: View {
    
    let content: [(text: String, width: CGFloat)]
    let font: Font
    
    init(content: [(text: String, width: CGFloat)], font: Font = .body) {
        self.content = content
        self.font = font
    }
    
    var body: some View {
        HStack(spacing: 3) {
            ForEach(content.indices) { idx in
                Text(content[idx].text)
                    .font(font)
                    .frame(
                        maxWidth: content[idx].width,
                        alignment: getAlignment(from: idx))
            }
        }
        .padding(5)
    }
}

struct RowStanding_Previews: PreviewProvider {
    
    static let placeHolder = Constats.shared.standingLMP.response.first[0]
    
    static var previews: some View {
        RowStanding(
            content: [
                (text: placeHolder.teamName, width: .infinity),
                (text: "\(placeHolder.wins)", width: 25),
                (text: "\(placeHolder.losses)", width: 25),
                (text: placeHolder.percent, width: 45),
                (text: placeHolder.gb, width: 35),
                (text: placeHolder.pts, width: 45),
            ])
    }
}

extension RowStanding {
    func getAlignment(from idx: Int) -> Alignment {
        content.first! == content[idx] ? .leading : .center
    }
}
