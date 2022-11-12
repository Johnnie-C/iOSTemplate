import XCTest
@testable import Common

final class CommonTests: XCTestCase {
    
    let validator = DefaultEmailValidator()
    
    func testValidEmail() {
        let email = "test@test.co.nz"
        XCTAssertTrue(validator.isValidEmail(email: email))
    }
    
    func testInvalidEmail_spaced() {
        let email = "test test@test.co.nz"
        XCTAssertFalse(validator.isValidEmail(email: email))
    }
    
}
