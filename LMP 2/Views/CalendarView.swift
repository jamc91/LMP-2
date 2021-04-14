//
//  CalendarView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 09/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    let deviceName = UIDevice.current.name
    
    var body: some View {
        ZStack {
            calendar
        }
        .padding([.horizontal, .bottom], 5)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background((viewModel.showDatePicker ? Color.black.opacity(0.8) : Color.clear)
        .onTapGesture {
            self.viewModel.showDatePicker = false
        }
        .disabled(!viewModel.showDatePicker))
        .ignoresSafeArea()
        .onChange(of: viewModel.date, perform: { value in
            viewModel.didTapDoneButton()
        })
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(ContentViewModel())
    }
}

extension CalendarView {
    var calendar: some View {
        DatePicker("", selection: $viewModel.date, displayedComponents: .date)
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding([.horizontal, .top])
            .offset(y: 20.0)
            .background(Color(.secondarySystemGroupedBackground))
            .mask(RoundedRectangle(cornerRadius: cornerRadius(device: deviceName), style: .continuous))
            .offset(y: viewModel.showDatePicker ? 0 : UIScreen.main.bounds.minY+470)
    }
}

extension CalendarView {
    func cornerRadius(device: String) -> CGFloat {
        switch device {
        case "iPhone X", "iPhone XS", "iPhone 11 Pro", "iPhone XS Max", "iPhone 11 Pro Max":
            return 35.0
        case "iPhone XR", "iPhone 11", "iPhone 12 mini":
            return 40.0
        case "iPhone 12", "iPhone 12 Pro":
            return 45.0
        case "iPhone 12 Pro Max":
            return 50.0
        default:
            return 10.0
        }
    }
}
