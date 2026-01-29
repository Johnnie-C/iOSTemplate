// **********************************************************
//    Copyright © 2026 Johnnie Cheng. All rights reserved.
// **********************************************************

import XCTest

public extension XCTestCase {
    
    func waitUntil(
        timeout: TimeInterval = 1,
        pollInterval: Duration = .milliseconds(10),
        _ condition: @escaping () -> Bool
    ) async throws {
        let start = Date()
        while !condition() {
            if Date().timeIntervalSince(start) > timeout {
                XCTFail("Timed out waiting for condition")
            }
            try await Task.sleep(for: pollInterval)
        }
    }
    
}
