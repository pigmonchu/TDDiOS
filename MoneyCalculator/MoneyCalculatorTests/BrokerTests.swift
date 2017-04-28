import XCTest
@testable import MoneyCalculator

class UnityBrokerTests: XCTestCase {
    
    var changeAuthority = UnityBroker(pattern: "EUR", ratesRespectPattern: ["EUR" : 1.0, "USD" : 2.0])
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    func testCanCreatechangeAuthority() {
        XCTAssertNotNil(self.changeAuthority)
    }
    
    func testEURPatronIsOne() {
        
        XCTAssertEqual(self.changeAuthority.value(OfCurrency: "EUR"), 1.0)
    }
    
    func testUSDPatronIsNotEqualOne() {
        XCTAssertEqual(self.changeAuthority.value(OfCurrency: "EUR"), 1.0)
        XCTAssertNotEqual(self.changeAuthority.value(OfCurrency: "USD"), 1.0)
        
    }
    
    func testNotOfficialCurrencyValueIsZero() {
        XCTAssertEqual(self.changeAuthority.value(OfCurrency: "EUR"), 1.0)
        XCTAssertEqual(self.changeAuthority.value(OfCurrency: "Monopoly"), nil)
    }
    
    func testchangeAuthorityConvertCurrencies() {
        XCTAssertEqual(try self.changeAuthority.rate(from: "EUR", to: "USD"), 2)
        XCTAssertEqual(try self.changeAuthority.rate(from: "EUR", to: "Monopoly"), 0.0)
        XCTAssertEqual(try self.changeAuthority.rate(from: "USD", to: "EUR"), 0.5)
        XCTAssertEqual(try self.changeAuthority.rate(from: "Monopoly", to: "USD"), 0.0)
        XCTAssertEqual(try self.changeAuthority.rate(from: "EUR", to: "EUR"), 1.0)
        XCTAssertEqual(try self.changeAuthority.rate(from: "USD", to: "USD"), 1.0)
    }
    
    func testWadHashValueInFractionaryUnitsOfPatronCurrency() {
        let emptyWad = Wad()
        let singleBillWad = Wad(42, currency: "USD")
        
        //Identity
        XCTAssertEqual(emptyWad, emptyWad)
        XCTAssertEqual(singleBillWad, singleBillWad)
        XCTAssertNotEqual(singleBillWad, emptyWad)
        
        //Equivalence
        let tenEuros = Wad(10)
        let twentyDollars = Wad(20, currency: "USD")
        
        let fiftyEuros = Wad(50)
        let oneHundredDollars = Wad(100, currency: "USD")
        let fifty1 = Wad(10).plus(tenEuros).plus(twentyDollars).plus(tenEuros).plus(twentyDollars)
        let fifty2 = Wad(60, currency: "USD").plus(tenEuros).plus(twentyDollars)
        
        XCTAssertEqual(fiftyEuros, oneHundredDollars)
        XCTAssertEqual(fiftyEuros, fifty1)
        XCTAssertEqual(fiftyEuros, fifty2)
        XCTAssertEqual(oneHundredDollars, oneHundredDollars)
        XCTAssertEqual(oneHundredDollars, fifty1)
        XCTAssertEqual(oneHundredDollars, fifty2)
        XCTAssertEqual(fifty1, fifty2)
    }
    
    
}
