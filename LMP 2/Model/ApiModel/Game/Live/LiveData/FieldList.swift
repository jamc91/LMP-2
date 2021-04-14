//
//  FieldList.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/11/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct FieldList: Identifiable, Codable {
    
    var id = UUID()
    let label: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case label, value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        label = try container.decode(forKey: .label, default: "")
        value = try container.decode(forKey: .value, default: "")
    }
    
    init(label: String = "", value: String = "") {
        self.label = label
        self.value = value
    }
}



