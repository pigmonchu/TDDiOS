import Foundation

struct UnityBroker: Rater, ChangeAuthority {
    
    let pattern: Currency
    
    var ratesRespectPattern: RatesDictionary
    
    func rate(from: String, to: String) throws -> Rate {
        return currencyToPattern(from) * patternTo(currency: to)
    }
    
    func currencyToPattern(_ currency: Currency) -> Rate {
        guard let rate = ratesRespectPattern[currency] else {
            return 0.0
        }
        return 1/rate
    }
    
    func patternTo(currency: Currency) -> Rate {
        guard let rate = ratesRespectPattern[currency] else {
            return 0.0
        }
        return rate
    }

    func value(OfCurrency currency: Currency) -> Rate? {
        return ratesRespectPattern[currency]
    }

}


