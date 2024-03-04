// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Combine
import Common

public struct LocationDemoView: View {
    
    @StateObject var viewModel: LocationDemoViewModel
    
    public init(
        viewModel: LocationDemoViewModel = LocationDemoViewModel()
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, commonSpacing: .xxxxLarge) {
                Group {
                    Text("Not much to be shown here.\n\nCheck ")
                        .font(FontStyle.body().dynamicFont) +
                    Text("LocationDemoViewModel ")
                        .font(FontStyle.body(weight: .semibold).dynamicFont) +
                    Text("for how to use ")
                        .font(FontStyle.body().dynamicFont) +
                    Text("LocationManager")
                        .font(FontStyle.body(weight: .semibold).dynamicFont)
                }
                .padding(.top, .large)
                .padding(.horizontal, .large)
                
                VStack(alignment: .center) {
                    Group {
                        Text("CurrentStatus: ")
                            .font(FontStyle.body(weight: .semibold).dynamicFont) +
                        Text(viewModel.authString)
                            .font(FontStyle.body().dynamicFont)
                    }
                    .padding(.horizontal, .large)
                    
                    Button("Request Permission") {
                        viewModel.requestLocationPermission()
                    }
                    .font(FontStyle.body().dynamicFont)
                    .padding(.horizontal, .large)
                    .fillWidth()
                    .standardHeight()
                }
                
                VStack(alignment: .center) {
                    Button("Request One off Location") {
                        viewModel.requestLocation()
                    }
                    .font(FontStyle.body().dynamicFont)
                    .padding(.horizontal, .large)
                    .fillWidth()
                    .standardHeight()
                    
                    if let latitude = viewModel.location?.coordinate.latitude,
                       let longitude = viewModel.location?.coordinate.longitude {
                        
                        Group {
                            Text("Current location: ")
                                .font(FontStyle.body(weight: .semibold).dynamicFont) +
                            Text("\(latitude), \(longitude)")
                                .font(FontStyle.body().dynamicFont)
                        }
                        .padding(.horizontal, .large)
                    }
                    
                    if let address = viewModel.address {
                        
                        Group {
                            Text("Address: ")
                                .font(FontStyle.body(weight: .semibold).dynamicFont) +
                            Text(address)
                                .font(FontStyle.body().dynamicFont)
                        }
                        .padding(.top, .xSmall)
                        .padding(.horizontal, .large)
                    }
                }
                
                Spacer()
            }
            .fillParent()
        }
        .fillParent()
    }

}
