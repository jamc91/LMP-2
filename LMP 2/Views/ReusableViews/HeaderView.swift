//
//  HeaderView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/21/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    
    var title: String
    var showCalendarButton: Bool
    var showPicker: (() -> Void)?
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.largeTitle)
            Spacer()
            if showCalendarButton {
                Button(action: {
                    withAnimation(.spring()) {
                        showPicker!()
                    }
                }) {
                    Image(systemName: "calendar.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.primary)
                }
            }
        }
        .frame(height: 80, alignment: .bottom)
        .padding(.horizontal, 20)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView(title: "Scoreboard", showCalendarButton: true).previewLayout(.sizeThatFits)
            HeaderView(title: "Scoreboard", showCalendarButton: true).previewLayout(.sizeThatFits).preferredColorScheme(.dark)
        }
    }
}
