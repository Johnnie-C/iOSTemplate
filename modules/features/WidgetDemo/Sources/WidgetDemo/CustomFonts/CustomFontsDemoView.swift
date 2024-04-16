// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Common

struct CustomFontsDemoView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, commonSpacing: .medium) {
                Text(
                    "A demo of useing Text with custom font.\nFonts are configed in Fonts.swift and provided by AppFontProvider.swift"
                )
                .font(.body())
                .padding(.bottom, .medium)
                
                Text("Default extraLargeTitle", fontStyle: .extraLargeTitle())
                Text("Default extraLargeTitle2", fontStyle: .extraLargeTitle2())
                Text("Default largeTitle", fontStyle: .largeTitle())
                Text("Default title1", fontStyle: .title1())
                Text("Default title2", fontStyle: .title2())
                Text("Default title3", fontStyle: .title3())
                Text("Default headline", fontStyle: .headline())
                Text("Default subheadline", fontStyle: .subheadline())
                Text("Default body", fontStyle: .body())
                Text("Default callout", fontStyle: .callout())
                Text("Default footnote", fontStyle: .footnote())
                Text("Default caption1", fontStyle: .caption1())
                Text("Default caption2", fontStyle: .caption2())
                    .padding(.bottom, .xLarge)
                
                Text("default Body")
                    .font(.body())
                Text("Body with .bold and italic")
                    .font(.body(weight: .bold, italic: true))
                Text("Body with .thin")
                    .font(.body(weight: .thin))
                Text("Body with .black")
                    .font(.body(weight: .black))
                Text("Body with .black and titleColor")
                    .font(.body(weight: .black))
                    .foregroundColor(.titleColor)
                Text("Body with .black and errorRed color")
                    .font(.body(weight: .black))
                    .foregroundColor(.errorRed)
                Text("Body with .black and errorRed color and 0.5 opacity")
                    .font(.body(weight: .black))
                    .foregroundColor(.errorRed, opacity: 0.5)
            }
            .padding(.vertical, .medium)
            .fillParent()
        }
        .fillParent()
        .navigationTitle("Font Demo")
    }

}
