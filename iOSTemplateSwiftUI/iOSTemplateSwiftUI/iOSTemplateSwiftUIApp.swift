//
//  iOSTemplateSwiftUIApp.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 23/10/21.
//

import SwiftUI

@main
struct iOSTemplateSwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ListView(viewModel: ListViewModel())
        }
    }
}
