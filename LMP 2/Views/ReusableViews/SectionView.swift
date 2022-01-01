//
//  SectionView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 31/12/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SectionView<Content, ButtonSection>: View where Content: View, ButtonSection: View {
    
    let title: String
    let buttonSection: ButtonSection
    let content: Content
    
    init(title: String, @ViewBuilder buttonSection: () -> ButtonSection, @ViewBuilder content: () -> Content) {
        self.title = title
        self.buttonSection = buttonSection()
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                buttonSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    content
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(title: "Test", buttonSection: {}) {
            ForEach(0..<5) { _ in
                VStack(alignment: .leading) {
                    GeometryReader { proxy in
                        WebImage(url: URL(string: "https://editor.lmp.mx/content/images/2021/12/LaMP-Yeison-Asencio-Aguilas-24dic21.jpg")!)
                                .resizable()
                            .scaledToFill()
                            .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("Friday 31 December, 2021")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    Text("Mayos de Navojoa at Naranjeros de Hermosillo")
                }
                .aspectRatio(1.2, contentMode: .fit)
            }
        }
        .frame(height: 250)
    }
}

extension SectionView where ButtonSection == EmptyView {
    init(title: String, content: () -> Content) {
        self.init(title: title, buttonSection: { EmptyView() }, content: content)
    }
}
