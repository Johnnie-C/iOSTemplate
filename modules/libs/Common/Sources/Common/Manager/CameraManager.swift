// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import AVFoundation
import SwiftUI

protocol CameraManagerProtocol {
    
    func cameraAuthorization(
        allows: Binding<Bool>,
        hasCamera: Binding<Bool>?
    )
    
}

// TODO: refactor to Publisher
class CameraManager: CameraManagerProtocol {
    
    static let shared = CameraManager()
    
    func cameraAuthorization(
        allows: Binding<Bool>,
        hasCamera: Binding<Bool>? = nil
    ) {
        if deviceHasCamera() {
            hasCamera?.wrappedValue = true
        } else {
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case.authorized:
            allows.wrappedValue = true
        case.notDetermined:
            AVCaptureDevice.requestAccess(for:.video) { granted in
                allows.wrappedValue = granted
            }
        case .denied, .restricted:
            return
        @unknown default:
            return
        }
        
    }
    
    func deviceHasCamera() -> Bool {
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
    
}
