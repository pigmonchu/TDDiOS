import XCTest
@testable import MoneyCalculator

class UnityBrokerTests: XCTestCase {
    
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
        let changeAuthority = ChangeAuthority()
        
        XCTAssertEqual(changeAuthority.value("EUR"), 1.0)
    }
    

}
