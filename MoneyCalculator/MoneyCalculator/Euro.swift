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
}

extension Euro : Equatable {
    public static func ==(lhs: Euro, rhs: Euro) -> Bool {
        return lhs._amount == rhs._amount
    }
}

