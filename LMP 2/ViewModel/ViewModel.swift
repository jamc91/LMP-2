//
//  ViewModelData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 26/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    var timer = Timer()
    
    @Published private(set) var games = [Games]()
    @Published var contentMLB = ContentResults()
    @Published private(set) var standingLMP = StandingLMP()
    @Published private(set) var standingMLB = StandingMLB()
    @Published var date = Date()
    @Published var showPickerView = false
    @Published private(set) var loadingState = ScoreboardLoadingState.loading
    
    init() {
        fetchData(url: .gamesLink(date: date.dateFormatter())) { (game: ScoreboardResults) in
            self.loadingState = game.dates.isEmpty ? .empty : .loaded
            self.timerStatus(state: game.totalGamesInProgress == 0)
            self.games = game.dates.flatMap { $0.games }
            
        }
        fetchData(url: .standingLMPLink) { (standing: StandingLMP) in
            self.standingLMP = standing
        }
        fetchData(url: .standingMLBLink) { (standingMLB: StandingMLB) in
            self.standingMLB = standingMLB
        }
    }
    
    func fetchData<T: Codable>(url: URL, completion: @escaping (T) -> ()) {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("Success")
                case .failure(let error):
                    debugPrint(error)
                }
            }, receiveValue: { result in
                completion(result)
            })
            .store(in: &cancellable)
    }

    func timerStatus(state: Bool) {
        if state {
            timer.invalidate()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
                self.fetchData(url: .gamesLink(date: self.date.dateFormatter())) { (games: ScoreboardResults) in
                    if games.totalGamesInProgress == 0 {
                        self.timer.invalidate()
                        print("Timer Invalidate")
                    }
                    self.games = games.dates.flatMap { $0.games }
                    
                }
            })
        }
    }
    func didTapCalendarButton() {
        timer.invalidate()
        showPickerView = true
    }
    
    func didTapAcceptButton() {
        games.removeAll()
        loadingState = .loading
        showPickerView = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchData(url: .gamesLink(date: self.date.dateFormatter())) { (game: ScoreboardResults) in
                self.loadingState = game.dates.isEmpty ? .empty : .loaded
                self.timerStatus(state: game.totalGamesInProgress == 0)
                self.games = game.dates.flatMap { $0.games }
            }
        }
    }
    
    func didTapCancelButton() {
        showPickerView = false
        timerStatus(state: false)
    }
}


