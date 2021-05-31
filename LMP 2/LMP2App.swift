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
    
    @StateObject private var viewModel = ContentViewModel()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .onChange(of: scenePhase) { state in
                    if state == .background { viewModel.stopTimer() }
                    if state == .active { viewModel.startTimer() }
            }
        }
    }
}
