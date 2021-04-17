//
//  RHEText.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 16/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct RHEText: View {
    let headerText: String
    let away: Int?
    let home: Int?
    
    var body: some View {
        VStack {
            Text(headerText)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 1)
            TextLinescore(text: away)
            TextLinescore(text: home)
        }
    }
}
