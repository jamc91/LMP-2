//
//  FooterPitchingStatsView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 13/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct FooterPitchingStatsView: View {
    
    var note: [FieldList]
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                ForEach(note) { note in
                    TextInfoView(label: note.label, value: note.value)
                }
            }
            Spacer()
        }
        .padding(5)
    }
}

struct FooterPitchingStatsView_Previews: PreviewProvider {
    static var previews: some View {
        FooterPitchingStatsView(note: Constats.shared.live.liveData.boxscore.info).previewLayout(.sizeThatFits)
    }
}
