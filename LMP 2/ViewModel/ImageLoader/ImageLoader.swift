//
//  ImageLoader.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    
    var cancellable: AnyCancellable?
    @Published var image = Image("default-player")
    
    init(url: String) {
        if let imageCache = ImageCache.shared.getImage(for: url) {
            self.image = Image(uiImage: imageCache)
        } else {
        guard let url = URL(string: url) else { return }
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map { $0.data }
            .map { UIImage(data: $0) }
            .replaceError(with: UIImage(named: "default-player"))
            .replaceNil(with: UIImage(named: "default-player")!)
            .eraseToAnyPublisher()
            .sink(receiveValue: { [weak self] image in
                ImageCache.shared.cache(image, for: url.absoluteString)
                self?.image = Image(uiImage: image)
            })
        }
    }
}
