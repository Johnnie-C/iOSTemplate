//
//  AppStyleConfig.swift
//  iOSTemplateSwiftUI
//
//  Created by Xiaojun Cheng on 23/11/22.
//

import UIKit
import Common

class AppStyleConfig {
    
    static func config() {
        configFont()
        configTabbar()
    }
    
    private static func configFont() {
        FontStyle.setFontProvider(AppFontProvider())
    }
    
    private static func configTabbar() {
        UITabBar.configTabBar(
            backgroundColor: Colors.secondaryColor.uiColor(),
            selectedItemStyle: .init(
                iconColor: Colors.primaryLabel.uiColor(),
                textColor: Colors.primaryLabel.uiColor(),
                font: FontStyle.caption2(weight: .semibold).staticUIFont,
                badgeColor: Colors.errorRed.uiColor()
            ),
            unselectedItemStyle: .init(
                iconColor: Colors.subtitleColor.uiColor(),
                textColor: Colors.subtitleColor.uiColor(),
                font: FontStyle.caption2(weight: .light).staticUIFont,
                badgeColor: Colors.errorRed.uiColor()
            )
        )
    }

}
