import XCTest
@testable import MoneyCalculator

class BillCalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCanCreateBill() {
        XCTAssertNotNil(Bill())
    }
    
    func testSimpleMultiplication5x2() {
        let five = Bill(5)
        let ten = five.times(2)
        let tenFix = Bill(10)
        XCTAssertEqual(ten, tenFix)
    }
    
    func testSimpleMultiplication5x3() {
        let five = Bill(5)
        let fifteen = five.times(3)
        let fifteenFix = Bill(15)
        XCTAssertEqual(fifteen, fifteenFix)
    }
    
    func testEquality() {
        let five = Bill(5)
        let otherFive = Bill(5)
        let ten = Bill(10)
        
        XCTAssertEqual(otherFive, otherFive)
        XCTAssertEqual(five, otherFive)
        
        XCTAssertNotEqual(five, ten)
    }
    
    func testEqualityAfterMathOperations() {
        let five = Bill(5)
        let firstOperation = five.times(1/3)
        let result = firstOperation.times(3)
        
        XCTAssertEqual(result, five)
    }
    
    func testEqualityAfterDivisionByThree() {
        let five = Bill(5)
        let firstOperation = five.times(1/3)
        let expectedResult = Bill(1.67)
        
        XCTAssertEqual(firstOperation, expectedResult)
    }
    
    func testInequalityCalculatedQuantitiesAndFixQuantity() {
        let five = Bill(5)
        let fixQ = Bill(1.67)
        
        let firstOperation = five.times(1/3)
        let secondOperation = five.times(3)

        let fixQOperation = fixQ.times(3)

        XCTAssertEqual(firstOperation, fixQ) // 1.6666666666666 == 1.67
        XCTAssertNotEqual(secondOperation, fixQOperation) // 5 != 5.01
    }

    func testThatObjectWithEqualHashAreEqual() {
//Es el mismo test que arriba, pero lo mantengo por si cambio la implementación que pete
        let five = Bill(5)
        let fixQ = Bill(1.67)
        
        let firstOperation = five.times(1/3)
        let secondOperation = five.times(3)
        
        let fixQOperation = fixQ.times(3)
        
        XCTAssertEqual(firstOperation.hashValue, fixQ.hashValue) // 167 == 167
        XCTAssertNotEqual(secondOperation.hashValue, fixQOperation.hashValue) // 500 != 501
    }

    func testThatHashValueIsWellFormed() {
        let five = Bill(5)
        let fixQ = Bill(50)
        let otherFive = Bill(5)
        
        XCTAssertEqual(five.hashValue, otherFive.hashValue)
        XCTAssertNotEqual(fixQ.hashValue, otherFive.hashValue)
    }

    func testSimpleAdd5plus10() {
        let five = Bill(5)
        let ten = Bill(10)
        let fifteen = ten.plus(five)
        let expectedResult = Bill(15)
        
        XCTAssertEqual(fifteen, expectedResult)
    }
    
    func testSimpleAdd5plus7() {
        let five = Bill(5)
        let seven = Bill(7)
        let twelve = seven.plus(five)
        let expectedResult = Bill(12)
        
        XCTAssertEqual(twelve, expectedResult)
    }
    
    func testConversionEuroToEuro() {
        let five = Bill(5)
        let newCurrency = five.reduced(to: "EUR", broker: Broker())
        
        XCTAssertEqual(newCurrency, five)        
    }
    
    func testCanCreateBroker() {
        let broker = Broker()
        
        XCTAssertNotNil(broker)
        XCTAssertEqual(try! broker.rate(from: "EUR", to: "EUR"), 1.0)

    }
    
    func testAddConversionFactorToBrokerEuroToUSDar() {
        // https://es.wikipedia.org/wiki/ISO_4217 ", to: " La clave de divisa será según este ISO
        
        var broker = Broker()
        broker.addRate(from: "EUR", to: "USD", rate: 2.0)
        
        XCTAssertEqual(try! broker.rate(from: "EUR", to: "USD"), 2.0)
        XCTAssertEqual(try! broker.rate(from: "USD", to: "EUR"), 0.5)
        XCTAssertEqual(try! broker.rate(from: "USD", to: "USD"), 1.0)
        XCTAssertEqual(try! broker.rate(from: "EUR", to: "EUR"), 1.0)
        
    }
    
    func testConversionEuroToUSDar() {
        let five = Bill(5)
        let broker = Broker(to: "USD", rate: 2.0)
        let newCurrency = five.reduced(to: "USD", broker: broker)
        
        XCTAssertEqual(try! broker.rate(from: "EUR", to: "USD"), 2.0)
        XCTAssertEqual(newCurrency.description, "USD10.0")
    }
    
    func testTenDollarsNotEqualTenEuros() {
        let tenUSD = Bill(10, currency: "USD")
        let tenEUR = Bill(10)
        
        XCTAssertNotEqual(tenUSD, tenEUR)
    }
    
}
