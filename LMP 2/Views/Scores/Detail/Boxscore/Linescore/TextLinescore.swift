//
//  TextLinescore.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 16/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TextLinescore: View {
    
    let text: Int?
    
    var body: some View {
        if let value = text {
            Text("\(value)")
                .font(.caption)
                .fontWeight(value > 0 ? .semibold : .regular)
        }
    }
}
