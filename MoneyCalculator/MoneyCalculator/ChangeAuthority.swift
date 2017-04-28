import Foundation

struct ChangeAuthority: Rater {
    var ratesRespectPattern: RatesDictionary = ["EUR" : 1.0, "USD" : 2.0]
    
    func value(_ currency: Currency) -> Rate {
        guard let result = ratesRespectPattern[currency] else {
            return 0
        }
        return result
    }

    func rate(from: Currency, to: Currency) throws -> Rate {
        throw BrokerErrors.unavailableFunction
    }
    
}
