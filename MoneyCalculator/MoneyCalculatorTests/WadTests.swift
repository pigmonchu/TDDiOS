import XCTest
@testable import MoneyCalculator

class WadCalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCanCreateWad() {
        XCTAssertNotNil(Wad())
    }
    
    func testSimpleMultiplication5x2() {
        let five = Wad(5)
        let ten = five.times(2)
        let tenFix = Wad(10)
        XCTAssertEqual(ten, tenFix)
    }
    
    func testSimpleMultiplication5x3() {
        let five = Wad(5)
        let fifteen = five.times(3)
        let fifteenFix = Wad(15)
        XCTAssertEqual(fifteen, fifteenFix)
    }
    
    func testEquality() {
        let five = Wad(5)
        let otherFive = Wad(5)
        let ten = Wad(10)
        
        XCTAssertEqual(otherFive, otherFive)
        XCTAssertEqual(five, otherFive)
        
        XCTAssertNotEqual(five, ten)
    }
    
    func testEqualityAfterMathOperations() {
        let five = Wad(5)
        let firstOperation = five.times(1/3)
        let result = firstOperation.times(3)
        
        XCTAssertEqual(result, five)
    }
    
    func testEqualityAfterDivisionByThree() {
        let five = Wad(5)
        let firstOperation = five.times(1/3)
        let expectedResult = Wad(1.67)
        
        XCTAssertEqual(firstOperation, expectedResult)
    }
    
    func testInequalityCalculatedQuantitiesAndFixQuantity() {
        let five = Wad(5)
        let fixQ = Wad(1.67)
        
        let firstOperation = five.times(1/3)
        let secondOperation = five.times(3)
        
        let fixQOperation = fixQ.times(3)
        
        XCTAssertEqual(firstOperation, fixQ) // 1.6666666666666 == 1.67
        XCTAssertNotEqual(secondOperation, fixQOperation) // 5 != 5.01
    }
    
    func testThatObjectWithEqualHashAreEqual() {
        //Es el mismo test que arriba, pero lo mantengo por si cambio la implementación que pete
        let five = Wad(5)
        let fixQ = Wad(1.67)
        
        let firstOperation = five.times(1/3)
        let secondOperation = five.times(3)
        
        let fixQOperation = fixQ.times(3)
        
        XCTAssertEqual(firstOperation.hashValue, fixQ.hashValue) // 167 == 167
        XCTAssertNotEqual(secondOperation.hashValue, fixQOperation.hashValue) // 500 != 501
    }
    
    func testThatHashValueIsWellFormed() {
        let five = Wad(5)
        let fixQ = Wad(50)
        let otherFive = Wad(5)
        
        XCTAssertEqual(five.hashValue, otherFive.hashValue)
        XCTAssertNotEqual(fixQ.hashValue, otherFive.hashValue)
    }
    
    func testSimpleAdd5plus10() {
        let five = Wad(5)
        let ten = Wad(10)
        let fifteen = ten.plus(five)
        let expectedResult = Wad(15)
        
        XCTAssertEqual(fifteen, expectedResult)
    }
    
    func testSimpleAdd5plus7() {
        let five = Wad(5)
        let seven = Wad(7)
        let twelve = seven.plus(five)
        let expectedResult = Wad(12)
        
        XCTAssertEqual(twelve, expectedResult)
    }
    
    func testConversionEuroToEuro() {
        let five = Wad(5)
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
        let five = Wad(5)
        let broker = Broker(to: "USD", rate: 2.0)
        let newCurrency = five.reduced(to: "USD", broker: broker)
        
        XCTAssertEqual(try! broker.rate(from: "EUR", to: "USD"), 2.0)
        XCTAssertEqual(newCurrency.description, "USD10.0")
    }
    
    func testTenDollarsNotEqualTenEuros() {
        let tenUSD = Wad(10, currency: "USD")
        let tenEUR = Wad(10)

        XCTAssertNotEqual(tenUSD, tenEUR)
    }
    
    func testEqualityWads() {
        let emptyWad = Wad()
        let singleBillWad = Wad(42, currency: "USD")
        
        //Identity
        XCTAssertEqual(emptyWad, emptyWad)
        XCTAssertEqual(singleBillWad, singleBillWad)
        XCTAssertNotEqual(singleBillWad, emptyWad)
        
        //Equivalence
        let tenEuros = Wad(10)
        let tenDollars = Wad(10, currency: "USD")
        
        let fiftyEuros = Wad(50)
        let fiftyDollars = Wad(50, currency: "USD")
        let fifty1 = Wad(10).plus(tenEuros).plus(tenDollars).plus(tenEuros).plus(tenDollars)
        let fifty2 = Wad(30, currency: "USD").plus(tenEuros).plus(tenDollars)
        
        XCTAssertEqual(fiftyEuros, fiftyDollars)
        XCTAssertEqual(fiftyEuros, fifty1)
        XCTAssertEqual(fiftyEuros, fifty2)
        XCTAssertEqual(fiftyDollars, fiftyDollars)
        XCTAssertEqual(fiftyDollars, fifty1)
        XCTAssertEqual(fiftyDollars, fifty2)
        XCTAssertEqual(fifty1, fifty2)
    }
    
    func testSimpleAdditionWad() {
        let singleBillWad = Wad(42, currency: "USD")
        
        XCTAssertEqual(singleBillWad.plus(Wad(8, currency: "USD")), Wad(50, currency: "USD"))
    }
    
    func testSimpleMultiplication() {
        let singleBillWad = Wad(42, currency: "USD")

        let eightyFour = singleBillWad.times(2)
        XCTAssertEqual(eightyFour, Wad(84, currency: "USD"))
        
    }
    
}
