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

extension FieldList {
    static var data: [FieldList] {[
        FieldList(label: "WP", value: "Scherzer; Harper, R."),
        FieldList(label: "IBB", value: "Freeman (by Harper, R); Soto (by Wright)."),
        FieldList(label: "Lanzamientos-strikes", value: "Wright 96-60; Matzek 14-9; O'Day 9-5; Minter 23-15; Martin 13-9; Scherzer 119-81; Suero 5-4; Finnegan 17-11; Harper, R 25-15; Bourque 9-6."),
        FieldList(label: "Roletazos-elevados de out", value: "Wright 7-3; Matzek 0-0; O'Day 0-0; Minter 0-0; Martin 2-0; Scherzer 1-4; Suero 0-0; Finnegan 0-0; Harper, R 0-1; Bourque 1-0."),
        FieldList(label: "Bateadores enfrentados", value: "Wright 27; Matzek 3; O'Day 2; Minter 4; Martin 3; Scherzer 27; Suero 2; Finnegan 3; Harper, R 7; Bourque 2."),
        FieldList(label: "Arbitros", value: "HP: Chris Conroy. 1B: Larry Vanover. 2B: David Rackley. 3B: Lance Barksdale."),
        FieldList(label: "Weather", value: "76 degrees, Partly Cloudy."),
        FieldList(label: "Wind", value: "4 mph, Out To RF."),
        FieldList(label: "T", value: "3:37."),
        FieldList(label: "Estadio", value: "Nationals Park."),
        FieldList(label: "September 13, 2020", value: "")
    ]}
}



