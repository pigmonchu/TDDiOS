import Foundation

struct Bill : Money {
    
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
    
    func times(_ times: Double) -> Bill {
        return Bill(self._amount * times, currency: self._currency)

    }
    
    func plus(_ sum: Bill) -> Bill {
        return Bill(sum._amount + self._amount)
    }
    
    func reduced<T: Rater>(to currency: Currency, broker: T) -> Bill {
        let rate = try! broker.rate(from: _currency, to: currency)
        
        return Bill(self._amount * rate, currency: currency)
    }
}

//MARK: - Protocols
extension Bill : Equatable {
    public static func ==(lhs: Bill, rhs: Bill) -> Bool {
        return lhs.hashValue == rhs.hashValue && lhs._currency == rhs._currency
    }
}

extension Bill : Hashable {
    public var hashValue: Int {
        get {
            let x = Double(round(100 * self._amount)/100)
            let s = Int(x*100)
            return s
        }
    }
}
