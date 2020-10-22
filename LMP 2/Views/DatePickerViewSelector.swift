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
                DatePickerGraphicalView(viewModel: viewModel)
            }
            .background(Color(.tertiarySystemBackground))
            .cornerRadius(15)
            .opacity(viewModel.showPickerView ? 1.0 : 0.0)
            .scaleEffect(viewModel.showPickerView ? 1.0 : 1.5)
            Spacer()
        }
        .padding(.horizontal, 30)
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
                self.viewModel.timerStatus(state: false)
            }
            Spacer()
            Button("Aceptar") {
                self.viewModel.gamesMLB.removeAll()
                self.viewModel.showActivityIndicator = true
                self.viewModel.showPickerView = false
                self.viewModel.timerStatus(state: false)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.viewModel.fetchData(url: .gamesLink(date: viewModel.date.dateFormatter()), placeholder: ScoreboardResults.default) { (game: ScoreboardResults) in
                        viewModel.timerStatus(state: game.totalGamesInProgress == 0)
                        viewModel.gamesMLB = game.dates
                        
                    }
                }
            }
        }.padding(.vertical)
        .padding(.horizontal, 20)
    }
}

struct DatePickerGraphicalView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        DatePicker("", selection: $viewModel.date, displayedComponents: .date)
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .frame(width: UIScreen.main.bounds.width / 1.3, alignment: .center)
    }
}
