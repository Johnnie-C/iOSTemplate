//
//  AppTabView.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 18/11/22.
//

import SwiftUI
import Product

struct AppTabView: View {
    
    var body: some View {
        TabView {
            DefaultProductAssembly().assembleProductListView()
                .tabItem {
//                    Label("Product Demo", systemImage: "flame.circle") // TODO
                    Label(
                        title: {
                            Text("Product Demo")
                        }, icon: {
                            Image(templateIcon: .info)
                        }
                    )
                }
            Text("PlaceHolder")
                .tabItem {
                    Label("Guideline Demo", systemImage: "ant") // TODO
                }
        }
        .onAppear {
//            UITabBar.configTabBar(
//                backgroundColor: .red,
//                tintColor: .green
//            )
        }
    }

}
