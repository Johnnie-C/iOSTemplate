// **********************************************************
//    Copyright © 2026 Johnnie Cheng. All rights reserved.
// **********************************************************

import Combine
import XCTest

public enum PublisherCaptureError: Error {
    case timeout
}

public extension Published.Publisher {
    
    /// Captures the next countofElement' of elements emitted by this publisher.
    ///
    /// Usage:
    /// ```swift
    /// let valueCapture = somePublisher.captureNext(2)
    /// await someAsyncAction()
    /// let values = try await valueCapture.results
    /// ```
    ///
    /// - Returns: ValueCapture object that can be awaited for the captured values.
    /// - Throws: `PublisherCaptureError.timeout` if not enough values arrive before `timeout`.
    ///
    func captureNext(
        _ countOfElement: Int,
        timeout: Duration = .seconds(2)
    ) throws -> ValueCapture {
        ValueCapture(
            self,
            countOfElement: countOfElement,
            timeout: timeout
        )
    }
    
    final class ValueCapture {
        
        private var values: [Output]?
        private var cancellable: AnyCancellable?
        private var timeoutTask: Task<Void, Never>?
        private let timeout: Duration
        private var error: Error?
        
        fileprivate init<P: Publisher>(
            _ publisher: P,
            countOfElement: Int,
            timeout: Duration = .seconds(2)
        ) where P.Output == Output, P.Failure == Never {
            self.timeout = timeout
            
            cancellable = publisher
                .dropFirst()
                .collect(countOfElement)
                .first()
                .sink { [weak self] values in
                    self?.values = values
                }
            
            startTimeout()
        }
        
        private func startTimeout() {
            timeoutTask = Task { [weak self, timeout] in
                try? await Task.sleep(for: timeout)
                self?.error = PublisherCaptureError.timeout
            }
        }
        
        var results: [Output] {
            get async throws {
                while true {
                    if let error {
                        throw error
                    } else {
                        if let values {
                            return values
                        } else {
                            try? await Task.sleep(for: .milliseconds(10))
                        }
                    }
                }
                
                throw PublisherCaptureError.timeout
            }
        }
        
    }
    
}
