import Foundation

struct Money {
    
    typealias Currency = String
    let _amount: Double
    let _currency: Currency
    
//MARK: - Initializers
    init(_ amount: Double, currency: Currency) {
        self._amount = amount
        self._currency = currency
    }
    
    init(_ amount: Double) {
        self.init(amount, currency: "EUR")
    }
    
    init () {
        self.init(0, currency: "EUR")
    }

//MARK: - Funcs
    var description: String {
        get {
            return "\(_currency)\(_amount)"
        }
    }
    
    func times(_ times: Double) -> Money {
        return Money(self._amount * times)
    }
    
    func plus(_ sum: Money) -> Money {
        return Money(sum._amount + self._amount)
    }
    
    func reduced(to currency: Currency, broker: Broker) -> Money {
        let rate = try! broker.rate(from: _currency, to: currency)
        
        return Money(self._amount * rate, currency: currency)
    }
}

//MARK: - Protocols
extension Money : Equatable {
    public static func ==(lhs: Money, rhs: Money) -> Bool {
        return lhs.hashValue == rhs.hashValue && lhs._currency == rhs._currency
    }
}

extension Money : Hashable {
    public var hashValue: Int {
        get {
            let x = Double(round(100 * self._amount)/100)
            let s = Int(x*100)
            return s
        }
    }
}
