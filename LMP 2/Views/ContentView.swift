//
//  ContentView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Group {
                GeneralTabView(viewModel: viewModel)
                PickerView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}

struct TopHeaderView: View {
    
    @ObservedObject var viewModel = ViewModel()
    var title: String
    var showCalendarButton: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.largeTitle)
            Spacer()
            if showCalendarButton {
                Button(action: {
                    self.viewModel.showPickerView = true
                    self.viewModel.timer.invalidate()
                }) {
                    Image(systemName: "calendar.circle.fill")
                        .font(.system(size: 35))
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.top, 50)
    }
}

struct HeaderSectionView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.system(size: 22))
            Spacer()
        }.padding(.top, 15)
    }
}
