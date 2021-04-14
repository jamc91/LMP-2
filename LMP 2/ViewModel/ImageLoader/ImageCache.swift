//
//  ImageCache.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

class ImageCache: NSCache<NSString, UIImage> {
    
    static let shared = ImageCache()
    
    func cache(_ image: UIImage, for key: String) {
        self.setObject(image, forKey: key as NSString)
    }
    
    func getImage(for key: String) -> UIImage? {
        self.object(forKey: key as NSString)
    }
}
