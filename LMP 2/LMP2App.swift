//
//  LMP2App.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/6/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

@main
struct LMP2App: App {
    
    @StateObject var contentViewModel = ContentViewModel()
    @Environment(\.scenePhase) var scenePhase
    @State private var showDatePicker = false
    @State private var presentSheet = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                TabBarView(contentViewModel: contentViewModel, showDatePicker: $showDatePicker, presentSheet: $presentSheet)
                .fullScreenCover(isPresented: $presentSheet) {
                    GameContentView(contentViewModel: contentViewModel)
                }
                .onChange(of: scenePhase) { state in
                    if state == .background { contentViewModel.stopTimer() }
                    if state == .active { contentViewModel.startTimer() }
                }
                DatePickerViewSelector(viewModel: contentViewModel, showPicker: $showDatePicker)
                    .zIndex(1)
            }
            .onAppear {
                contentViewModel.loadData()
            }
        }
    }
}
