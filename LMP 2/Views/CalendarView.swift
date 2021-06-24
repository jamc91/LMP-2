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
        ZStack(alignment: .top) {
            calendar
        }
        .padding([.horizontal, .bottom], 7)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background((viewModel.showDatePicker ? Color.black.opacity(0.7) : Color.clear)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                self.viewModel.showDatePicker = false
                            }
                        }
                        .disabled(!viewModel.showDatePicker))
        .ignoresSafeArea()
        .onChange(of: viewModel.date, perform: { value in
            withAnimation(.spring()) {
                viewModel.changeDate()
            }
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
            .mask(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
            .offset(y: viewModel.showDatePicker ? 0 : UIScreen.main.bounds.minY+470)
    }
}
