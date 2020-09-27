//
//  PickerView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 19/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct PickerView: View {
    
    @ObservedObject var viewModel = ViewModel()
   
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing: 0) {
                HStack {
                    CancelButton(viewModel: viewModel)
                    Spacer()
                    Text("Cambiar fecha")
                        .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
                    Spacer()
                    AcceptButton(viewModel: viewModel)
                }
              //  TodayButton(date: $viewModel.dateNow)
                Picker(selection: $viewModel.league, label: Text("Picker"), content: {
                    Text("MLB").tag(League.MLB)
                    Text("LMP").tag(League.LMP)
                }).pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 30)
                DatePickerView(viewModel: viewModel)
                
            }
            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .offset(y: self.viewModel.showPickerView ? 0 : UIScreen.main.bounds.height)
        }.background((self.viewModel.showPickerView ? Color.black.opacity(0.5) : Color.clear)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.viewModel.showPickerView = false
                        })
        .edgesIgnoringSafeArea(.all)
        .animation(.spring())
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        
        PickerView()

    }
}

struct TodayButton: View {
    
    @Binding var date: Date
    
    var body: some View {
        Button(action: {
            date = Date()
        }) {
            Text("Hoy")
        }.padding(.top)
    }
}

struct AcceptButton: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
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
        .frame(width: 70, height: 20, alignment: .center)
        .padding()
    }
}

struct CancelButton: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
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
        .frame(width: 70, height: 20, alignment: .center)
        .padding()
    }
}

struct DatePickerView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        DatePicker("", selection: self.$viewModel.dateNow, displayedComponents: .date)
            .labelsHidden()
            .environment(\.locale, Locale.init(identifier: "es"))
            .datePickerStyle(GraphicalDatePickerStyle())
            .frame(width: UIScreen.main.bounds.width / 1.2, alignment: .center)
    }
}
