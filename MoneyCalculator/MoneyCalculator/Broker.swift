import Foundation

struct Broker {
    var _rate: [String : Double]
    
    init() {
        _rate = [:]
        self.addRate(from: "EUR", to: "EUR", rate: 1.0)
    }
    
    mutating func addRate(from: String, to: String, rate: Double) {
        _rate["\(from)->\(to)"] = rate
        _rate["\(to)->\(from)"] = 1/rate
        _rate["\(from)->\(from)"] = 1
        _rate["\(to)->\(to)"] = 1
    }

}
