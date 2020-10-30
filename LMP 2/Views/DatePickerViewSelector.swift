//
//  DatePickerViewSelector.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/09/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct DatePickerViewSelector: View {
    
    @ObservedObject var viewModel: ViewModel
    
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
                            viewModel.didTapCancelButton()
                        })
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(response: 0.3, dampingFraction: 1.0, blendDuration: 0.3))
    }
}

struct DatePickerViewSelector_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerViewSelector(viewModel: ViewModel())
    }
}

struct TopButtons: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Button("Cancel") {
                viewModel.didTapCancelButton()
            }
            Spacer()
            Button("Accept") {
                viewModel.didTapAcceptButton()
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
