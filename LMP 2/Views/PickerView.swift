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
        VStack (spacing: 0) {
                HStack {
                    Button("Cancelar") {
                        
                        self.viewModel.showPickerView = false
                       
                    }
                    .frame(width: 70, height: 20, alignment: .center)
                    .padding()
                    Spacer()
                    Text("Cambiar fecha")
                        .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
                    Spacer()
                    Button("Aceptar") {
                        self.viewModel.games.removeAll()
                        self.viewModel.showPickerView = false
                        self.viewModel.fetchGames()
                    }
                    .frame(width: 70, height: 20, alignment: .center)
                    .padding()
                }
                Button(action: {
                    self.viewModel.dateNow = Date()
                }) {
                    Text("Hoy")
                }.padding(.top)
                DatePicker("", selection: self.$viewModel.dateNow,in: ...Date(), displayedComponents: .date)
                    .labelsHidden()
                    .environment(\.locale, Locale.init(identifier: "es"))
            }
            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(viewModel: ViewModel()).previewLayout(.sizeThatFits)

    }
}
