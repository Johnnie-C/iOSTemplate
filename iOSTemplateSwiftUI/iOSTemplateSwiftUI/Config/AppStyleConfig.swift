// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit
import Common

class AppStyleConfig {
    
    static func config() {
        configFont()
        configTabbar()
        configNavigationBar()
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
    
    private static func configNavigationBar() {
        let tintColor = Colors.secondaryColor.uiColor()
        let buttonAttributes = UINavigationBar.TitleTextAttributes(
            font: FontStyle.body().staticUIFont,
            color: .black
        )
        let doneButtonAttributes = UINavigationBar.TitleTextAttributes(
            font: FontStyle.body(weight: .semibold).staticUIFont,
            color: tintColor
        )
        let backgroundColor = Colors.primaryColor.uiColor()
        UINavigationBar.configTabBar(
            backgroundColor: backgroundColor,
            tintColor: tintColor,
            titleAttributes: .init(
                font: FontStyle.title3().staticUIFont,
                color: tintColor
            ),
            largeTitleAttributes: .init(
                font: FontStyle.largeTitle(weight: .semibold).staticUIFont,
                color: tintColor
            ),
            plainButtonAttributes: buttonAttributes,
            doneButtonAttributes: doneButtonAttributes,
            backButtonAttributes: buttonAttributes,
            shadowColor: backgroundColor
        )
    }

}
