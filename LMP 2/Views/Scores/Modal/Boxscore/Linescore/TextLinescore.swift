//
//  TextLinescore.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 10/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TextLinescore: View {
    
    let value: String?
    let away: Int
    let home: Int
    
    var body: some View {
        VStack(spacing: 5) {
            if let text = value {
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
            }
            Text(String(away))
                .font(.caption)
                .fontWeight(away > 0 && (value == nil || value!.contains("R")) ? .bold : .regular)
            Text(String(home))
                .font(.caption)
                .fontWeight(home > 0 && (value == nil || value!.contains("R")) ? .bold : .regular)
        }
        .frame(width: 20)
    }
}

struct TextLinescore_Previews: PreviewProvider {
    static var previews: some View {
        TextLinescore(value: "R", away: 1, home: 2)
    }
}
