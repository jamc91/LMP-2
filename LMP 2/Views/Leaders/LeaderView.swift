//
//  LeaderView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 31/12/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

struct LeaderView: View {
    
    @StateObject private var leadersViewModel = LeadersViewModel()
    
    var body: some View {
        SectionView(title: "Leaders of Batting") {
            ForEach(leadersViewModel.leaders) { leader in
                VStack {
                    LeaderImageURL(url: leader.img, name: leader.abbreviate)
                    Text(leader.name)
                        .font(.subheadline)
                }
            }
        }
    }
}

struct LeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderView()
           
    }
}

final class LeaderImageWebViewModel: ObservableObject {
    
    @Published var image: Image?
    var cancellables = Set<AnyCancellable>()
    
    init(url: String) {
        getImage(url: url)
    }
    
    func getImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .map { UIImage(data: $0)}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Success!")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { image in
                if let safeImage = image, safeImage.size.width > 100 {
                    self.image = Image(uiImage: safeImage)
                }
            })
            .store(in: &cancellables)
    }
}

struct LeaderImageURL: View {
    @StateObject private var leaderImageUrlViewModel: LeaderImageWebViewModel
    let name: String
    
    init(url: String, name: String) {
        self._leaderImageUrlViewModel = StateObject(wrappedValue: LeaderImageWebViewModel(url: url))
        self.name = name
    }
    
    var body: some View {
        if let image = leaderImageUrlViewModel.image {
            GeometryReader { _ in
                image
                    .resizable()
                    .scaledToFill()
                
            }
            .background(Color(.systemGray5))
            .frame(width: 110, height: 110)
            .clipShape(Circle())
        } else {
            Circle().fill(Color(.systemGray4))
                .frame(width: 110, height: 110)
                .overlay {
                    Text(name)
                        .font(.system(size: 55, weight: .light))
                        .foregroundColor(.white)
                }
        }
    }
}
