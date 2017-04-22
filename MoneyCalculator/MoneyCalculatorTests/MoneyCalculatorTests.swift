import XCTest
@testable import MoneyCalculator

class MoneyCalculatorTests: XCTestCase {
    
    let five = Euro(5)
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCanCreateEuro() {
        XCTAssertNotNil(Euro())
    }
    
    func testSimpleMultiplication5x2() {
        let ten = five.times(2)
        let tenFix = Euro(10)
        XCTAssertEqual(ten, tenFix)
    }
    
    func testSimpleMultiplication5x3() {
        let fifteen = five.times(3)
        let fifteenFix = Euro(15)
        XCTAssertEqual(fifteen, fifteenFix)
    }
    
    func testEquality() {
        let otherFive = Euro(5)
        let ten = Euro(10)
        
        XCTAssertEqual(otherFive, otherFive)
        XCTAssertEqual(five, otherFive)
        
        XCTAssertNotEqual(five, ten)
    }
}
