// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Common

struct ImageButtonDemoView: View {
    
    @State var toastMessage: ToastMessage? = nil
    @State var fillWidthSquareButtonShakeTrigger = false
    @State var fillWidthRoundedButtonStatus = ImageButton.Status.normal
    
    var body: some View {
        ScrollView {
            VStack(commonSpacing: .medium) {
                HStack {
                    squareButton
                    roundedCornerButton
                    roundedButton
                }
                .padding(.top, .large)
                
                HStack(commonSpacing: .xLarge) {
                    sizedIconOnlyButton
                    sizedButton
                }
                
                fillWidthSquareButton
                fillWidthRoundedButton
                fillWidthRoundedCornerDisabledButton
                customButton
                
                Spacer()
            }
        }
        .navigationTitle("Image Button Demo")
        .fillParent()
        .toastMessage(toastMessage: $toastMessage)
    }
    
    private var squareButton: some View {
        ImageButton(
            title: "Square",
            status: .normal,
            config: .init(shape: .square)
        ) {
            alert("Square Button Tapped")
        }
    }
    
    private var roundedButton: some View {
        ImageButton(
            title: "Rounded",
            status: .normal,
            config: .init(shape: .rounded)
        ) {
            alert("Rounded Button Tapped")
        }
    }
    
    private var roundedCornerButton: some View {
        ImageButton(
            title: "Rounded Corner",
            status: .normal,
            config: .init(shape: .roundedCorner(10))
        ) {
            alert("Rounded Corner Button Tapped")
        }
    }
    
    private var sizedIconOnlyButton: some View {
        ImageButton(
            icon: .system("square.and.arrow.up.circle"),
            status: .normal,
            config: .init(
                style: .sized(CGSize(width: 100, height: 150)),
                shape: .roundedCorner(10),
                font: .largeTitle(weight: .bold)
            )
        ) {
            alert("Icon Only Button Tapped")
        }
    }
    
    private var sizedButton: some View {
        ImageButton(
            title: "Sized Button",
            status: .normal,
            config: .init(
                style: .sized(CGSize(width: 100, height: 150)),
                shape: .roundedCorner(10)
            )
        ) {
            alert("Sized Button Tapped")
        }
    }
    
    private var fillWidthSquareButton: some View {
        ImageButton(
            title: "Fill Width Square Button",
            status: .normal,
            config: .init(
                style: .fillWidth,
                shape: .square,
                color: .infoBlue,
                tintColor: .secondaryColor
            )
        ) {
            fillWidthSquareButtonShakeTrigger.toggle()
        }
        .padding(.horizontal, .large)
        .shake(trigger: fillWidthSquareButtonShakeTrigger)
    }
    
    private var fillWidthRoundedButton: some View {
        ImageButton(
            title: "Fill Width rounded Button",
            icon: .system("trash"),
            status: fillWidthRoundedButtonStatus,
            config: .init(
                style: .fillWidth,
                shape: .rounded
            )
        ) {
            fillWidthRoundedButtonStatus = .loading
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                fillWidthRoundedButtonStatus = .success {
                    fillWidthRoundedButtonStatus = .normal
                }
            }
        }
        .padding(.horizontal, .large)
    }
    
    private var fillWidthRoundedCornerDisabledButton: some View {
        ImageButton(
            title: "Fill Width Rounded Corner Disabled Button",
            status: .disabled,
            config: .init(
                style: .fillWidth,
                shape: .roundedCorner(10)
            )
        ) {
            
        }
        .padding(.horizontal, .large)
    }
    
    private var customButton: some View {
        ImageButton(
            title: "Custom Button",
            icon: .info,
            status: .normal,
            config: .init(
                style: .sized(CGSize(width: 300, height: 200)),
                shape: .roundedCorner(10),
                font: .largeTitle(weight: .heavy, italic: true),
                color: .errorRed,
                tintColor: .custom(.white),
                padding: EdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40),
                iconPadding: .xLarge
            )
        ) {
            alert("Custom Button Tapped")
        }
    }
    
    private func alert(_ message: String) {
        toastMessage = ToastMessage(
            title: message,
            toastMode: .banner(.pop)
        )
    }
    
}
