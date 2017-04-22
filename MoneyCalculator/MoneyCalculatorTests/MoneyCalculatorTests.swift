import XCTest
@testable import MoneyCalculator

class MoneyCalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCanCreateMoney() {
        XCTAssertNotNil(Money())
    }
    
    func testSimpleMultiplication5x2() {
        let five = Money(5)
        let ten = five.times(2)
        let tenFix = Money(10)
        XCTAssertEqual(ten, tenFix)
    }
    
    func testSimpleMultiplication5x3() {
        let five = Money(5)
        let fifteen = five.times(3)
        let fifteenFix = Money(15)
        XCTAssertEqual(fifteen, fifteenFix)
    }
    
    func testEquality() {
        let five = Money(5)
        let otherFive = Money(5)
        let ten = Money(10)
        
        XCTAssertEqual(otherFive, otherFive)
        XCTAssertEqual(five, otherFive)
        
        XCTAssertNotEqual(five, ten)
    }
    
    func testEqualityAfterMathOperations() {
        let five = Money(5)
        let firstOperation = five.times(1/3)
        let result = firstOperation.times(3)
        
        XCTAssertEqual(result, five)
    }
    
    func testEqualityAfterDivisionByThree() {
        let five = Money(5)
        let firstOperation = five.times(1/3)
        let expectedResult = Money(1.67)
        
        XCTAssertEqual(firstOperation, expectedResult)
    }
    
    func testInequalityCalculatedQuantitiesAndFixQuantity() {
        let five = Money(5)
        let fixQ = Money(1.67)
        
        let firstOperation = five.times(1/3)
        let secondOperation = five.times(3)

        let fixQOperation = fixQ.times(3)

        XCTAssertEqual(firstOperation, fixQ) // 1.6666666666666 == 1.67
        XCTAssertNotEqual(secondOperation, fixQOperation) // 5 != 5.01
    }

    func testThatObjectWithEqualHashAreEqual() {
//Es el mismo test que arriba, pero lo mantengo por si cambio la implementación que pete
        let five = Money(5)
        let fixQ = Money(1.67)
        
        let firstOperation = five.times(1/3)
        let secondOperation = five.times(3)
        
        let fixQOperation = fixQ.times(3)
        
        XCTAssertEqual(firstOperation.hashValue, fixQ.hashValue) // 167 == 167
        XCTAssertNotEqual(secondOperation.hashValue, fixQOperation.hashValue) // 500 != 501
    }

    func testThatHashValueIsWellFormed() {
        let five = Money(5)
        let fixQ = Money(50)
        let otherFive = Money(5)
        
        XCTAssertEqual(five.hashValue, otherFive.hashValue)
        XCTAssertNotEqual(fixQ.hashValue, otherFive.hashValue)
    }

    func testSimpleAdd5plus10() {
        let five = Money(5)
        let ten = Money(10)
        let fifteen = ten.plus(five)
        let expectedResult = Money(15)
        
        XCTAssertEqual(fifteen, expectedResult)
    }
    
    func testSimpleAdd5plus7() {
        let five = Money(5)
        let seven = Money(7)
        let twelve = seven.plus(five)
        let expectedResult = Money(12)
        
        XCTAssertEqual(twelve, expectedResult)
    }
    
    func testConversionEuroToEuro() {
        let five = Money(5)
        let newCurrency = five.reduced(to: "EUR", broker: Broker())
        
        XCTAssertEqual(newCurrency, five)        
    }
    
    func testCanCreateBroker() {
        let broker = Broker()
        
        XCTAssertNotNil(broker)
        XCTAssertEqual(broker._rate["EUR->EUR"], 1.0)

    }
    
    func testAddConversionFactorToBrokerEuroToDolar() {
        // https://es.wikipedia.org/wiki/ISO_4217 -> La clave de divisa será según este ISO
        
        var broker = Broker()
        broker.addRate(from: "EUR", to: "DOL", rate: 2.0)
        
        XCTAssertEqual(broker._rate["EUR->DOL"], 2.0)
        XCTAssertEqual(broker._rate["DOL->EUR"], 0.5)
        XCTAssertEqual(broker._rate["DOL->DOL"], 1.0)
        XCTAssertEqual(broker._rate["EUR->EUR"], 1.0)
        
    }
    
    func testConversionEuroToDolar() {
        let five = Money(5)
        let broker = Broker(to: "DOL", rate: 2.0)
        let newCurrency = five.reduced(to: "DOL", broker: broker)
        
        XCTAssertEqual(broker._rate["EUR->DOL"], 2.0)
        XCTAssertEqual(newCurrency._amount, 10)
    }
    
}
