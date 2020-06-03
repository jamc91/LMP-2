//
//  View+typeerasure.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
