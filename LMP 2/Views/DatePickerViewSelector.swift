//
//  DatePickerViewSelector.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/09/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct DatePickerViewSelector: View {
    
    @ObservedObject var viewModel: ContentViewModel
    @Binding var showPicker: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                DatePickerGraphicalView(viewModel: viewModel, showPicker: $showPicker)
                    .offset(y: showPicker ? 0 : UIScreen.main.bounds.minY+470)
                Spacer()
            }
        }
        .background((showPicker ? Color.black.opacity(0.6) : Color.clear)
                        .ignoresSafeArea()
                        .onTapGesture {
                            viewModel.startTimer()
                            withAnimation(.spring()) {
                                showPicker = false
                            }
                        }
                        .disabled(!showPicker))
    }
}

struct DatePickerViewSelector_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            DatePickerViewSelector(viewModel: ContentViewModel(), showPicker: .constant(true)).preferredColorScheme(.light).previewLayout(.sizeThatFits)
            DatePickerViewSelector(viewModel: ContentViewModel(), showPicker: .constant(true)).preferredColorScheme(.dark).previewLayout(.sizeThatFits)
        }
    }
}

struct DatePickerGraphicalView: View {

    @ObservedObject var viewModel: ContentViewModel
    @Binding var showPicker: Bool
    
    var body: some View {
        VStack (spacing: 0) {
            DatePicker("New Date", selection: $viewModel.date, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding([.top, .horizontal])
            Divider()
            HStack {
                Button(action: {
                    didTapCancelButton()
                }) {
                    Text("Cancel")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .frame(width: 120, height: 40, alignment: .center)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                Spacer()
                Button(action: {
                    didTapApplyButton()
                }) {
                    Group {
                        Image(systemName: "checkmark")
                        Text("Apply")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                }
                .frame(width: 120, height: 40, alignment: .center)
                .background(Color(.systemBlue))
                .cornerRadius(10)
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width / 1.10)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(20)
    }
    private func didTapApplyButton() {
        withAnimation(.spring()) {
            showPicker = false
        }
        viewModel.loadingState = .loading
        viewModel.scheduledGames.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            viewModel.startTimer()
            viewModel.getScheduledGames()
        }
    }
    private func didTapCancelButton() {
        withAnimation(.spring()) {
            showPicker = false
        }
        viewModel.startTimer()
    }
}
