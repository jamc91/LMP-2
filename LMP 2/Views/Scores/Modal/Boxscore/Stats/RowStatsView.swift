//
//  RowStatsView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 11/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct RowStatsView: View {
    
    let type: RowType
    let content: [(text: String, width: CGFloat)]
    
    init(type: RowType, content: [(text: String, width: CGFloat)]) {
        self.type = type
        self.content = content
    }
    
    var body: some View {
        HStack(spacing: 3) {
            ForEach(content.indices) { idx in
                Text(content[idx].text)
                    .font(.caption)
                    .fontWeight(getFontWeight(from: idx))
                    .foregroundColor(getFontColor())
                    .frame(
                        maxWidth: getWidth(from: idx),
                        alignment: getAlignment(from: idx))
            }
        }
        .padding(5)
    }
}

struct RowStatsView_Previews: PreviewProvider {
    static var previews: some View {
        RowStatsView(type: .Header, content: [("BATTING", CGFloat.infinity), ("AB", CGFloat(20)), ("R", CGFloat(15)), ("H", CGFloat(15)), ("RBI", CGFloat(25)), ("BB", CGFloat(20)), ("SO", CGFloat(20)), ("LOB", CGFloat(25)), ("AVG", CGFloat(25)), ("OPS", CGFloat(25))]).previewLayout(.sizeThatFits)
    }
}

extension RowStatsView {
    func getWidth(from idx: Int) -> CGFloat {
        return content[idx].width
    }
    
    func getAlignment(from idx: Int) -> Alignment {
        content.first! == content[idx] ? .leading : .center
    }
    
    func getFontWeight(from idx: Int) -> Font.Weight {
        switch type {
        case .Stats:
            return content.first! == content[idx] ? .semibold : .regular
        case .Header:
            return .regular
        case .Totals:
            return .semibold
        }
    }
    
    func getFontColor() -> Color {
        switch type {
        case .Stats, .Totals:
            return .primary
        case .Header:
            return .secondary
        }
    }
}

enum RowType {
    case Stats
    case Header
    case Totals
}
