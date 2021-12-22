//
//  CalendarView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 09/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    
    @Binding var date: Date
    @Binding var show: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            calendar
        }
        .padding([.horizontal, .bottom], 7)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background((show ? Color.black.opacity(0.7) : Color.clear)
                        .onTapGesture {
            withAnimation(.spring()) {
                show = false
            }
        }
        .disabled(!show))
        .ignoresSafeArea()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(date: .constant(Date()), show: .constant(false))
    }
}

extension CalendarView {
    var calendar: some View {
        DatePicker("", selection: $date, displayedComponents: .date)
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding([.horizontal, .top])
            .offset(y: 20.0)
            .background(Color(.secondarySystemGroupedBackground))
            .mask(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
            .offset(y: show ? 0 : UIScreen.main.bounds.minY+470)
    }
}
