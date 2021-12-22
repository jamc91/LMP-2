//
//  StandingsViewModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 30/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

final class StandingsViewModel: ObservableObject {
    
    @Published var standingLMP: StandingLMP?
    @Published var standingMLB: StandingMLB?
    
    init() {
        getStandingsLMP()
      //  getStandingsMLB()
    }
    
    func getStandingsLMP() {
        ApiService.shared.getData(with: EndPoint.standingLMP) { [weak self] (result: Result<StandingLMP, ApiError>) in
            switch result {
            case .success(let standingLMP):
                self?.standingLMP = standingLMP
            case .failure(let apiError):
                self?.printApiErrorMessage(error: apiError)
            }
        }
    }
    
    func getStandingsMLB() {
        ApiService.shared.getData(with: EndPoint.standingMLB) { [weak self] (result: Result<StandingMLB, ApiError>) in
            switch result {
            case .success(let standingMLB):
                self?.standingMLB = standingMLB
            case .failure(let apiError):
                self?.printApiErrorMessage(error: apiError)
            }
        }
    }
    
    private func printApiErrorMessage(error: ApiError) {
        switch error {
        case .decodingError(let errorDecoding):
            debugPrint(errorDecoding)
        case .httpError(let statusCode):
            print("error http \(statusCode)")
        case .unknown:
            print("error desconocido")
        }
    }
}
