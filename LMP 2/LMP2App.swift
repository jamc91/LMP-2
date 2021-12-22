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
    
    @StateObject private var scoresViewModel = ScoresViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(scoresViewModel)
        }
    }
}
