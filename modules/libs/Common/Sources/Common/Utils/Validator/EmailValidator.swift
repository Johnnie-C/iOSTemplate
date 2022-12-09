// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation

public protocol EmailValidator {
    
    func isValidEmail(email: String?) -> Bool
    
}

public class DefaultEmailValidator: EmailValidator {
    
    public init() { }
    
    public func isValidEmail(email: String?) -> Bool {
        let emailRegEx = "^[_'A-Za-z0-9-\\+]+(\\.\"\\w*\")*(\\.[_'A-Za-z0-9-]+)*@[A-Za-z0-9][A-Za-z0-9-]*(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }

}
