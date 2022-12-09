// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Combine
import Alamofire

extension DataResponsePublisher {

    func asFuture() -> Future<Value, Error> {
        return Future { promise in
            var cancellable: AnyCancellable? = nil
            cancellable = self.sink(
                receiveCompletion: {
                    cancellable?.cancel()
                    cancellable = nil
                    switch $0 {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished:
                        break
                    }
            },
                receiveValue: {
                    cancellable?.cancel()
                    cancellable = nil
                    if let value = $0.value {
                        promise(.success(value))
                    }
                    else if let error = $0.error {
                        promise(.failure(error))
                    }
                    else {
                        promise(.failure(NetworkerError.unknown))
                    }
            })
        }
    }

}
