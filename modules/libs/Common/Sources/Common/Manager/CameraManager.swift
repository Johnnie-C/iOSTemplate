// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import AVFoundation
import SwiftUI


protocol CameraManagerProtocol: ObservableObject {
    
    var hasCamera: Bool { get }
    var hasPermission: Bool { get }
    
    func requestPermission(state: Binding<AVAuthorizationStatus>)
    
}

class CameraManager: CameraManagerProtocol {
    
    static let shared = CameraManager()
    
    public var hasCamera: Bool {
        let frontCamera = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .front
        )
        let backCamera = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .back
        )
        
        return frontCamera != nil || backCamera != nil
    }
    
    var hasPermission: Bool {
        AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }
    
    func requestPermission(state: Binding<AVAuthorizationStatus>) {
        let currentState = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch currentState {
        case .notDetermined:
            Task {
                let granted = await AVCaptureDevice.requestAccess(for: .video)
                state.wrappedValue = granted ? .authorized : .denied
            }
        default:
            state.wrappedValue = currentState
        }
        
    }
    
}
