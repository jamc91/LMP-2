//
//  SelectorTeamPickerView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/9/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct SelectorTeamPickerView: View {
    
    let awayTeamName: String
    let homeTeamName: String
    @Binding var selectionTeam: SelectionTeam
    
    var body: some View {
        Picker("Select Team", selection: $selectionTeam) {
            Text(awayTeamName).tag(SelectionTeam.away)
            Text(homeTeamName).tag(SelectionTeam.home)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

struct SelectorTeamPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectorTeamPickerView(awayTeamName: "Mayos", homeTeamName: "Naranjeros", selectionTeam: .constant(.home)).previewLayout(.sizeThatFits)
    }
}
