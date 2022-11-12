//
//  XCTestCase+Publisher.swift
//  
//
//  Created by Johnnie Cheng on 27/10/22.
//

import Combine
import XCTest

public extension XCTestCase {
    
    @discardableResult
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        forAction action: (() -> Void)? = nil,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")
        
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }
                
                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success (value)
            }
        )
        
        action?()
        waitForExpectations(timeout: timeout)
        cancellable.cancel()
        
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )
        
        return try unwrappedResult.get()
    }
    
}
