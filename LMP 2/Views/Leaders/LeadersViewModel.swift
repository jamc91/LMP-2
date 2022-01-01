//
//  LeadersViewModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 31/12/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

final class LeadersViewModel: ObservableObject {
    
    @Published var leaders = [Leader]()
    
    init() {
        getLeaders()
    }
    
    func getLeaders() {
        ApiService.shared.getData(with: EndPoint.leaders("batting", 10, "regular")) { (response: Result<LeadersResponse, ApiError>) in
            switch response {
            case .success(let response):
                self.leaders = response.leaders
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
