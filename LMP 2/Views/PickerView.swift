//
//  PickerView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 19/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct PickerView: View {
    
    @ObservedObject var viewModel: RowViewModel
   
    var body: some View {
            VStack {
                HStack {
                    Button(action: {
                        
                        self.viewModel.showPickerView = false
                       
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(Color(.systemGray2))
                    }
                    .padding()
                    Spacer()
                    Text("Cambiar fecha")
                        .font(.system(.headline, design: .rounded))
                        .bold()
                        .foregroundColor(.primary)
                    Spacer()
                    Button(action: {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "YYYY/MM/dd"
                        self.viewModel.date = formatter.string(from: self.viewModel.dateNow)
                        self.viewModel.showPickerView = false
                        self.viewModel.parseData()

                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(Color(.systemGray2))
                    }.padding()
                }
                DatePicker("", selection: self.$viewModel.dateNow, displayedComponents: .date)
                    .labelsHidden()
                    .environment(\.locale, Locale.init(identifier: "es"))
                    .padding(.bottom)
                
            }
            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .background(Color("BackgroundCell"))
            .cornerRadius(10)
  
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(viewModel: RowViewModel()).previewLayout(.sizeThatFits)

    }
}
