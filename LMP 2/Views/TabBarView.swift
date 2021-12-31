//
//  tabBarView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var scoresViewModel: ScoresViewModel
    @State private var selectedTab = 0
    @State private var showDatePicker = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag(0)
            ScoresView() {
                showDatePicker = true
            }
            .tag(1)
            .environmentObject(scoresViewModel)
        }
        .onChange(of: scoresViewModel.date, perform: { newValue in
            scoresViewModel.changeDate()
            withAnimation(.spring()) {
                showDatePicker = false
            }
        })
        .overlay {
            CalendarView(date: $scoresViewModel.date, show: $showDatePicker)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        TabBarView()
            .environmentObject(ScoresViewModel())
    }
}
