// **********************************************************
//    Copyright © 2026 Johnnie Cheng. All rights reserved.
// **********************************************************

import XCTest

public extension XCTestCase {
    
    /// !!! Try to avoid using this if you can !!!
    ///
    /// Assert async operation after a given time.
    ///
    /// This is a workaround for testing the following case to verify` functionToVerify` is eventually called with correct `parameters`
    ///
    /// ```swift
    /// func functionToTest() {
    ///     Task {
    ///         ...
    ///         await service. functionToVerify(parameters: parameters)
    ///         ...
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    /// - description: description for expectation
    /// - after: time duration to execute action
    /// - timeout: timeout for expectation
    /// - action: action block to execute
    func expectAsync(
        description: String = #function,
        after: Duration = .milliseconds(50),
        timeout: TimeInterval = 1,
        action: @escaping @Sendable () async -> Void
    ) async {
        let expectation = self.expectation(description: description)
        Task {
            try await Task.sleep(for: after)
            await action()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: timeout)
    }
    
}
