//
//  DatePickerViewSelector.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/09/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct DatePickerViewSelector: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                TopButtons(viewModel: viewModel)
                LeagueSegmentedPicker(viewModel: viewModel)
                DatePickerGraphicalView(viewModel: viewModel)
                
            }
            .background(Color(.tertiarySystemBackground))
            .cornerRadius(15)
            .opacity(viewModel.showPickerView ? 1.0 : 0.0)
            .scaleEffect(viewModel.showPickerView ? 1.0 : 0.4)
            Spacer()
        }
        .padding()
        .background((self.viewModel.showPickerView ? Color.black.opacity(0.5) : Color.clear)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.viewModel.showPickerView = false
                        })
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(response: 0.3, dampingFraction: 1.0, blendDuration: 0.3))
    }
}

struct DatePickerViewSelector_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerViewSelector().padding().previewLayout(.sizeThatFits)
    }
}

struct TopButtons: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Button("Cancelar") {
                self.viewModel.showPickerView = false
                self.viewModel.timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true, block: { _ in
                    self.viewModel.loadData(url: .games(date: self.viewModel.dateNow.dateFormatter(),league: viewModel.league)) { (resultsMLB: resultsMLB) in
                        if resultsMLB.totalGamesInProgress == 0 {
                            self.viewModel.timer.invalidate()
                        }
                        self.viewModel.gamesMLB = resultsMLB.dates
                    }
                })
            }
            Spacer()
            Button("Aceptar") {
                self.viewModel.gamesMLB.removeAll()
                self.viewModel.showActivityIndicator = true
                self.viewModel.showPickerView = false
                self.viewModel.timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true, block: { _ in
                    self.viewModel.loadData(url: .games(date: self.viewModel.dateNow.dateFormatter(), league: viewModel.league)) { (resultsMLB: resultsMLB) in
                        if resultsMLB.totalGamesInProgress == 0 {
                            self.viewModel.timer.invalidate()
                        }
                        self.viewModel.gamesMLB = resultsMLB.dates
                    }
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.viewModel.loadData(url: .games(date: self.viewModel.dateNow.dateFormatter(), league: viewModel.league)) { (resultsMLB: resultsMLB) in
                        if resultsMLB.totalGamesInProgress == 0 {
                            self.viewModel.timer.invalidate()
                        }
                        self.viewModel.gamesMLB = resultsMLB.dates
                    }
                }
            }
        }.padding()
    }
}

struct LeagueSegmentedPicker: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Picker("", selection: $viewModel.league) {
                Text("MLB").tag(League.MLB)
                Text("LMP").tag(League.LMP)
            }
            .padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct DatePickerGraphicalView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        DatePicker("", selection: $viewModel.dateNow, displayedComponents: .date)
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .frame(width: UIScreen.main.bounds.width / 1.2, alignment: .center)
    }
}
