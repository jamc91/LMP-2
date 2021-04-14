//
//  WebImage.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct WebImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        self.imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        imageLoader.image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct WebImage_Previews: PreviewProvider {
    static var previews: some View {
        WebImage(url: "https://img.mlbstatic.com/mlb-photos/image/upload/w_426,q_100/v1/people/458708/headshot/67/current")
    }
}
