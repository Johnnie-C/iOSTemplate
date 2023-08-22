// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import AVFoundation
import SwiftUI


public protocol CameraManagerProtocol: ObservableObject {
    
    var hasCamera: Bool { get }
    var hasPermission: Bool { get }
    
    func requestPermission() async -> AVAuthorizationStatus
    
}

class CameraManager: CameraManagerProtocol {
    
    static let shared = CameraManager()
    
    var hasCamera: Bool {
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
    
    func requestPermission() async -> AVAuthorizationStatus {
        let currentState = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch currentState {
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            return granted ? .authorized : .denied
        default:
            return currentState
        }
    }
    
}
