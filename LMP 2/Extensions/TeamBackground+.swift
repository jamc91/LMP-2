//
//  TeamBackground+.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/12/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    func backgroundTeam(id: Int) -> Color {
        switch id {
        case 680:
            return Color("blue")
        case 5482:
            return Color("brown")
        case 5483:
            return Color("darkBlue")
        case 677:
            return Color("Orange")
        case 678:
            return Color("cayenne")
        case 676:
            return Color("red")
        case 673:
            return Color("red")
        case 674:
            return Color("blue")
        default:
            return Color.white
        }
    }
}
