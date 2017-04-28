import Foundation

struct ChangeAuthority: Rater {
    var ratesRespectPattern: RatesDictionary = ["EUR" : 1.0, "USD" : 2.0]
    
    func value(_ currency: Currency) -> Rate {
        return ratesRespectPattern[currency]!
    }
    
    
}
