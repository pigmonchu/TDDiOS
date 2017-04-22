import Foundation

struct Money {
    
    typealias Currency = String
    
    let _amount: Double
    
    init(_ amount: Double) {
        self._amount = amount
    }
    
    init () {
        self.init(0)
    }
    
    func times(_ times: Double) -> Money {
        return Money(self._amount * times)
    }
    
    func plus(_ sum: Money) -> Money {
        return Money(sum._amount + self._amount)
    }
    
    func reduced(to currency: Currency, broker: Broker) -> Money {
        return Money(self._amount)
    }
}

extension Money : Equatable {
    public static func ==(lhs: Money, rhs: Money) -> Bool {
        return lhs.hashValue == rhs.hashValue
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
