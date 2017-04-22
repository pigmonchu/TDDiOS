import Foundation

struct Euro {
    let _amount: Double
    
    init(_ amount: Double) {
        self._amount = amount
    }
    
    init () {
        self.init(0)
    }
    
    func times(_ times: Double) -> Euro {
        return Euro(self._amount * times)
    }
    
    func plus(_ sum: Euro) -> Euro {
        return Euro(sum._amount + self._amount)
    }
}

extension Euro : Equatable {
    public static func ==(lhs: Euro, rhs: Euro) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension Euro : Hashable {
    public var hashValue: Int {
        get {
            let x = Double(round(100 * self._amount)/100)
            let s = Int(x*100)
            return s
        }
    }
}
