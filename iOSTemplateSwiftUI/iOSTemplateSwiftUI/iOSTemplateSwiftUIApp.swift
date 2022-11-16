//
//  iOSTemplateSwiftUIApp.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 23/10/21.
//

import SwiftUI
import Product

@main
struct iOSTemplateSwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            DefaultProductAssembly().assembleProductListView()
        }
    }
}
