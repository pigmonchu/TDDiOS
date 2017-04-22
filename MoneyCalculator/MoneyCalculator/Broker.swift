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
    
    mutating func addRate(from: String, to: String, rate: Double) {
        _rate["\(from)->\(to)"] = rate
        _rate["\(to)->\(from)"] = 1/rate
        _rate["\(from)->\(from)"] = 1
        _rate["\(to)->\(to)"] = 1
    }
    
    func rate(from: String, to: String) throws -> Double {
        guard let rate = _rate["\(from)->\(to)"] else {
            throw BrokerErrors.unknownRate
        }
        return rate
    }
    
}
