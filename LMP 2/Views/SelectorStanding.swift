//
//  SelectorStanding.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 02/06/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct selectorStandingView: View {

    @ObservedObject var standingData = RowViewModel()
   
    var body: some View {
            VStack {
                Button(action: {
                    self.standingData.showSelector = false
                    self.standingData.standingIs = "Regular"
                    self.standingData.standingType = 0
                }) {
                    HStack (spacing: 20) {
                       Image(systemName: "arrow.2.squarepath")
                        .foregroundColor(.secondary)
                       Text("Cambiar a Regular")
                        .foregroundColor(.primary)
                    }
                }.padding(.leading)
                .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
                    Button(action: {
                        self.standingData.showSelector = false
                        self.standingData.standingIs = "Playoffs"
                        self.standingData.standingType = 0
                    }) {
                        HStack (spacing: 20) {
                           Image(systemName: "arrow.2.squarepath")
                            .foregroundColor(.secondary)
                           Text("Cambiar a Playoffs")
                            .foregroundColor(.primary)
                        }
                    }.padding(.leading)
                    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
                
                Button("Cancelar") {
                    self.standingData.showSelector = false
                }.frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                    .background(Color(.systemGray6))
                    .cornerRadius(25)
                    .foregroundColor(.primary)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                
                
                
            }.padding()
            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .background(Color("BackgroundCell"))
        .cornerRadius(15)
    }
}

struct SelectorStanding_Previews: PreviewProvider {
    static var previews: some View {
        
        selectorStandingView(standingData: RowViewModel()).previewLayout(.sizeThatFits)
        
        
    }
}
