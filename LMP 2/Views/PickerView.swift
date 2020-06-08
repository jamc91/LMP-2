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
                        let formatter = DateFormatter()
                        formatter.dateFormat = "YYYY/MM/dd"
                        self.viewModel.date = formatter.string(from: self.viewModel.dateNow)
                        self.viewModel.showPickerView = false
                        self.viewModel.parseData()

                    }
                    .frame(width: 70, height: 10, alignment: .center)
                    .padding()
                }
                DatePicker("Cambiar fecha", selection: self.$viewModel.dateNow, displayedComponents: .date)
                    .labelsHidden()
                    .environment(\.locale, Locale.init(identifier: "es"))
                
            }
            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .background(Color("BackgroundCell"))
            .cornerRadius(10)
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(viewModel: ViewModel()).previewLayout(.sizeThatFits)

    }
}
