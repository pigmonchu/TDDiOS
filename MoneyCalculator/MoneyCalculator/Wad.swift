import Foundation

typealias Bills = [Bill]

struct Wad {
    var _bills : Bills
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
    
    mutating func addBill() {
        _bills.append(Bill())
    }
    
    mutating func addBill(_ bill: Bill) {
        _bills.append(bill)
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
    
    func reduced(to currency: Currency, broker: Broker) -> Wad {
        return self
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

//MARK: - Protocols
extension Wad : Equatable {
    public static func ==(lhs: Wad, rhs: Wad) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension Wad : Hashable {
    public var hashValue: Int {
        get {
            let accum = self._bills.reduce ( 0, {x, y in
                x + Double(round(100 * y._amount)/100)
            })
            
            return Int(accum * 100)
        }
    }
    
}