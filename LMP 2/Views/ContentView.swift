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
            ListView(viewModel: viewModel).onAppear {
                self.viewModel.loadContent()
            }
            PickerView(viewModel: viewModel)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()        
    }
}
