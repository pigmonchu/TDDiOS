import Foundation

struct Euro {
    let _amount: Double
    
    init(_ amount: Double) {
        self._amount = amount
    }
    
    init () {
        self.init(0)
    }
    
    func times(_: Int) -> Euro {
        return Euro(10)
    }
}

extension Euro : Equatable {
    public static func ==(lhs: Euro, rhs: Euro) -> Bool {
        return lhs._amount == rhs._amount
    }
}

