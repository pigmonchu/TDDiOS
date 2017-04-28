import Foundation

typealias Bills = [Bill]

struct Wad {
    var _bills : Bills
    static let unityBroker = UnityBroker(pattern: "EUR", ratesRespectPattern: ["EUR" : 1.0, "USD" : 2])
    
    //ver la posibilidad de implementar en Wad el protocolo Broker
}

extension Wad : Money {
    
//MARK: - Initializers
    init(_ amount: Double, currency: Currency) {
        self.init()
        self.addBill(amount, currency: currency)
    }
    
    init(_ amount: Double) {
        self.init()
        self.addBill(amount)
    }
    
    init() {
        self._bills = []
    }
    
    
//MARK: - Funcs
    mutating func addBill(_ amount: Double, currency: Currency) {
        _bills.append(Bill(amount, currency: currency))
    }
    
    mutating func addBill(_ amount: Double) {
        _bills.append(Bill(amount))
    }
    
    func times(_ times: Double) -> Wad {
        var result = Wad()
        
        result._bills = self._bills.map {
            $0.times(times)
        }
        return result
    }
    
    func plus(_ sum: Wad) -> Wad {
        var result = Wad()
        
        result._bills = self._bills
        result._bills += sum._bills

        return result
    }
    
    func reduced<T: Rater>(to currency: Currency, broker: T) -> Wad {
        var result = Wad()
        
        result._bills = self._bills.map {
            $0.reduced(to: currency, broker: broker)
        }
        
        return result
    }
    
    func reduced(to: Currency) -> Wad {
        return reduced(to: to, broker: Wad.unityBroker)
    }
    
    var description: String {
        get {
            var dsc: String = ""
            if self._bills.count == 0 {
                return dsc
            }
            
            dsc = self._bills[0].description
            
            var i=1
            while i<self._bills.count {
                dsc += ("+" + self._bills[i].description)
                i += 1
            }
            return dsc
        }
    }
}

extension Wad: Rater {
    func rate(from: Currency, to: Currency) throws -> Rate {
        return try Wad.unityBroker.rate(from: from, to: to)
    }
}

//MARK: - Protocols
extension Wad : Equatable {
    public static func ==(lhs: Wad, rhs: Wad) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension Wad : Hashable {
    public var hashValue: Int {
        get {
            let accum = self._bills.reduce ( 0.0, {x, y in
                x + Double(round(100 * y.reduced(to: "EUR", broker: Wad.unityBroker)._amount)/100)
            })
            
            return Int(accum * 100)
        }
    }
    
}
