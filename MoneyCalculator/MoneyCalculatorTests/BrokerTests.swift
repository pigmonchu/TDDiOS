import XCTest
@testable import MoneyCalculator

class UnityBrokerTests: XCTestCase {
    
    let changeAuthority = ChangeAuthority()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()

    }
    
    func testCanCreateChangeAuthority() {        
        XCTAssertNotNil(ChangeAuthority())
    }
    
    func testEURPatronIsOne() {
        
        XCTAssertEqual(changeAuthority.value("EUR"), 1.0)
    }
    
    func testUSDPatronIsNotEqualOne() {
        XCTAssertEqual(changeAuthority.value("EUR"), 1.0)
        XCTAssertNotEqual(changeAuthority.value("USD"), 1.0)
        
    }
    
    func testNotOfficialCurrencyValueIsZero() {
        XCTAssertEqual(changeAuthority.value("EUR"), 1.0)
        XCTAssertEqual(changeAuthority.value("Monopoly"), 0.0)
    }
}
