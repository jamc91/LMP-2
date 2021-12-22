//
//  TimerManager.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 30/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

final class TimerManager {
    @Published var timer: Timer?
    @Published var timerStopped = false
    
    /// Detiene Timer.
    func stopTimer() {
        print("Timer Invalidado")
        timer?.invalidate()
        timer = nil
        timerStopped = true
    }
    
    /// Inicia Timer.
    func startTimer(getGames: @escaping () -> Void) {
        timerStopped = false
        print("Timer Inicializado")
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { _ in
            getGames()
        })
    }
}
