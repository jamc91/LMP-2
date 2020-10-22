//
//  ContentView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            GeneralTabView(viewModel: viewModel)
                .zIndex(0)
                .modifier(AnimationBlur(showBlur: $viewModel.showPickerView))
            DatePickerViewSelector(viewModel: viewModel)
                .zIndex(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}

struct AnimationBlur: ViewModifier {
    
    @Binding var showBlur: Bool
    
    func body(content: Content) -> some View {
        return content
            .animation(nil)
            .blur(radius: showBlur ? 8.0 : 0.0)
            .animation(.spring())
    }
}


