//
//  ContentViewTest.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 11/29/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TextListView: View {
    
    var name: String
    var nameFontWeight: Font.Weight
    var nameColor: Color
    var info: [(text: String, width: CGFloat)]
    var isSubstitute: Bool?
    var textFontWeight: Font.Weight
    var textColor: Color
    
    var body: some View {
        HStack (spacing: 5) {
            Text(name)
                .font(.caption)
                .fontWeight(nameFontWeight)
                .foregroundColor(nameColor)
                .padding(.leading, isSubstitute ?? false ? 20 : 0)
            Spacer()
            ForEach(info.indices) { idx in
                Text(info[idx].text)
                    .font(.caption)
                    .fontWeight(textFontWeight)
                    .foregroundColor(textColor)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(width: info[idx].width)
            }
        }
        .padding(.vertical, 3)
        .padding(.horizontal, 10)
    }
}

struct ContentViewTest_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextListView(name: "Guzman, M, 2B", nameFontWeight: .bold, nameColor: .primary, info: [(text: "1", width: 20), (text: "0", width: 20), (text: "0", width: 20), (text: "0", width: 20), (text: "0",width: 20), (text: "0", width: 20), (text: "0", width: 35), (text: ".283", width: 35), (text: ".864", width: 35)], textFontWeight: .bold, textColor: .secondary).previewLayout(.sizeThatFits)
            TextListView(name: "Guzman, M, 2B", nameFontWeight: .bold, nameColor: .primary, info: [(text: "1", width: 20), (text: "0", width: 20), (text: "0", width: 20), (text: "0", width: 20), (text: "0",width: 20), (text: "0", width: 20), (text: "0", width: 35), (text: ".283", width: 35), (text: ".864", width: 35)], textFontWeight: .bold, textColor: .secondary).previewLayout(.sizeThatFits).preferredColorScheme(.dark)
        }
    }
}
