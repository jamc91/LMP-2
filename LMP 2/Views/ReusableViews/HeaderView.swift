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
                    Image(systemName: "calendar")
                        .imageScale(.large)
                        
                }
                .buttonStyle(.bordered)
                .clipShape(Circle())
                .tint(.blue)
            }
        }
        .frame(height: 50, alignment: .bottom)
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
