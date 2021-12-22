//
//  ContentView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var scoresViewModel: ScoresViewModel
    @State private var showDatePicker = false
    
    var body: some View {
        ZStack {
            TabBarView() {
                showDatePicker = true
            }
            CalendarView(date: $scoresViewModel.date, show: $showDatePicker)
        }
        .onChange(of: scoresViewModel.date) { value in
            withAnimation(.spring()) {
                scoresViewModel.changeDate()
                showDatePicker = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ScoresViewModel())
    }
}
