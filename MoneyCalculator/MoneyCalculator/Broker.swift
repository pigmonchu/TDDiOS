import Foundation

enum BrokerErrors: Error {
    case unknownRate
}

struct Broker {
    var _rate: [String : Double]
    
    init() {
        _rate = [:]
        self.addRate(from: "EUR", to: "EUR", rate: 1.0)
    }
    
    init(to: String, rate: Double) {
        self.init()
        self.addRate(from: "EUR", to: to, rate: rate)
    }
    
    private func keyConversion(from: String, to:String) -> String {
        return "\(from)->\(to)"
    }
    
    mutating func addRate(from: String, to: String, rate: Double) {
        _rate[keyConversion(from: from, to: to)] = rate
        _rate[keyConversion(from: to, to: from)] = 1/rate
        _rate[keyConversion(from: from, to: from)] = 1
        _rate[keyConversion(from: to, to: to)] = 1
    }
    
    func rate(from: String, to: String) throws -> Double {
        guard let rate = _rate[keyConversion(from: from, to: to)] else {
            throw BrokerErrors.unknownRate
        }
        return rate
    }
    
}
