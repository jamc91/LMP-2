//
//  ImageLoader.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 01/06/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation


class ImageLoader: ObservableObject {
    
   @Published var downLoadedData: Data?
    
    func downloadImage(url: String) {
        
        guard let imageURL = URL(string: url) else {
            fatalError("error")
        }
        
        DispatchQueue.main.async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.downLoadedData = data
            }
                
            
        }
        
        
    }

}
