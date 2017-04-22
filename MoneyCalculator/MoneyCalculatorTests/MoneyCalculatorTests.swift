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
    
    func testEqualityAfterMathOperations() {
        let firstOperation = five.times(1/3)
        let result = firstOperation.times(3)
        
        XCTAssertEqual(result, five)
    }
    
    func testEqualityAfterDivisionByThree() {
        let firstOperation = five.times(1/3)
        let expectedResult = Euro(1.67)
        
        XCTAssertEqual(firstOperation, expectedResult)
    }
    
    func testInequalityCalculatedQuantitiesAndFixQuantity() {
        let fixQ = Euro(1.67)
        
        let firstOperation = five.times(1/3)
        let secondOperation = five.times(3)

        let fixQOperation = fixQ.times(3)

        XCTAssertEqual(firstOperation, fixQ) // 1.6666666666666 == 1.67
        XCTAssertNotEqual(secondOperation, fixQOperation) // 5 != 5.01
        
    }

    func testThatObjectWithEqualHashAreEqual() {
//Es el mismo test que arriba, pero lo mantengo por si cambio la implementación que pete
        let fixQ = Euro(1.67)
        
        let firstOperation = five.times(1/3)
        let secondOperation = five.times(3)
        
        let fixQOperation = fixQ.times(3)
        
        XCTAssertEqual(firstOperation.hashValue, fixQ.hashValue) // 167 == 167
        XCTAssertNotEqual(secondOperation.hashValue, fixQOperation.hashValue) // 500 != 501
        
    }

    func testThatHashValueIsWellFormed() {
        let fixQ = Euro(50)
        let otherFive = Euro(5)
        
        XCTAssertEqual(five.hashValue, otherFive.hashValue)
        XCTAssertNotEqual(fixQ.hashValue, otherFive.hashValue)
    }

    func testSimpleAdd5plus10() {
        let ten = Euro(10)
        let fifteen = ten.plus(five)
        let expectedResult = Euro(15)
        
        XCTAssertEqual(fifteen, expectedResult)
    }
    
    func testSimpleAdd5plus7() {
        let seven = Euro(7)
        let twelve = seven.plus(five)
        let expectedResult = Euro(12)
        
        XCTAssertEqual(twelve, expectedResult)
    }
}
