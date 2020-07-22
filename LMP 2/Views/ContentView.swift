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
        Group {
            if viewModel.showMainActivityIndicator {
                VStack (alignment: .center) {
                    ActivityIndicator(showIndicator: $viewModel.showMainActivityIndicator, style: .medium)
                        .onAppear(perform: self.viewModel.loadContent)
                    Text("Cargando")
                        .foregroundColor(.secondary)
                }
            } else {
                ZStack {
                    ListView(viewModel: viewModel)
                    PickerView(viewModel: viewModel)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

struct HeaderView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        HStack (alignment: .bottom){
            Text("Resumen")
                .font(Font.largeTitle)
                .bold()
            Spacer()
            Button(action: {
                self.viewModel.timer.invalidate()
                self.viewModel.showPickerView.toggle()
            }) {
                Image(systemName: "calendar.circle.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.primary)
                    .frame(width: 35, height: 50, alignment: .center)
            }.buttonStyle(PlainButtonStyle())
        }
    }
}
