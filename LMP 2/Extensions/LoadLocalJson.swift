//
//  LoadLocalJson.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ url: String) -> T {
        guard let url = self.url(forResource: url, withExtension: nil) else { fatalError("Error al crear URL") }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonDecoded = try decoder.decode(T.self, from: data)
            return jsonDecoded
        } catch {
            debugPrint(error)
            fatalError("Error al decodificar JSON")
        }
    }
}
