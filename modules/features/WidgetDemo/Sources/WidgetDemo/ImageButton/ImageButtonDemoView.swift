// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Common

struct ImageButtonDemoView: View {
    
    @StateObject fileprivate var viewModel = ImageButtonDemoViewModel()
    
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
        .toastMessage(toastMessage: $viewModel.toastMessage)
        .bottomSheet(
            isPresented: $viewModel.isPresentBottomSheet,
            estimatedHeight: viewModel.estimatedHeight
        ) {
            bottomSheetView
        }
    }
    
    private var bottomSheetView: some View {
        VStack(commonSpacing: .medium) {
            Text(viewModel.bottomSheetText)
            ImageButton(title: "Dismiss") {
                viewModel.isPresentBottomSheet = false
            }
        }
        .padding(.medium)
    }
    
    private var squareButton: some View {
        ImageButton(
            title: "Square",
            status: .normal,
            config: .init(shape: .square)
        ) {
//            alert("Square Button Tapped")
            viewModel.bottomSheetText = .shortLipsum
            viewModel.estimatedHeight = .small
            viewModel.isPresentBottomSheet = true
        }
    }
    
    private var roundedButton: some View {
        ImageButton(
            title: "Rounded",
            status: .normal,
            config: .init(shape: .rounded)
        ) {
//            alert("Rounded Button Tapped")
            viewModel.bottomSheetText = .longLipsum
            viewModel.estimatedHeight = .large
            viewModel.isPresentBottomSheet = true
        }
    }
    
    private var roundedCornerButton: some View {
        ImageButton(
            title: "Rounded Corner",
            status: .normal,
            config: .init(shape: .roundedCorner(10))
        ) {
//            alert("Rounded Corner Button Tapped")
            viewModel.bottomSheetText = .mediumLipsum
            viewModel.estimatedHeight = .medium
            viewModel.isPresentBottomSheet = true
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
//            alert("Icon Only Button Tapped")
            viewModel.bottomSheetText = .xLongLipsum
            viewModel.estimatedHeight = .large
            viewModel.isPresentBottomSheet = true
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
            viewModel.fillWidthSquareButtonShakeTrigger.toggle()
        }
        .padding(.horizontal, .large)
        .shake(trigger: viewModel.fillWidthSquareButtonShakeTrigger)
    }
    
    private var fillWidthRoundedButton: some View {
        ImageButton(
            title: "Fill Width rounded Button",
            icon: .system("trash"),
            status: viewModel.fillWidthRoundedButtonStatus,
            config: .init(
                style: .fillWidth,
                shape: .rounded
            )
        ) {
            viewModel.fillWidthRoundedButtonStatus = .loading
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                viewModel.fillWidthRoundedButtonStatus = .success {
                    viewModel.fillWidthRoundedButtonStatus = .normal
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
        viewModel.toastMessage = ToastMessage(
            title: message,
            toastMode: .banner(.pop)
        )
    }
    
}

private class ImageButtonDemoViewModel: ObservableObject {
    
    @Published var toastMessage: ToastMessage? = nil
    @Published var fillWidthSquareButtonShakeTrigger = false
    @Published var fillWidthRoundedButtonStatus = ImageButton.Status.normal
    
    @Published var isPresentBottomSheet = false
    @Published var estimatedHeight: BottomSheetEstimatedHeight = .small
    @Published var bottomSheetText = ""
    
}

private extension String {
    
    static var shortLipsum: String {
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis"
    }

    static var mediumLipsum: String {
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis"
    }
    
    static var longLipsum: String {
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. "
    }
    
    static var xLongLipsum: String {
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum."
    }
    
}
