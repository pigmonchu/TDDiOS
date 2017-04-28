import Foundation

enum BrokerErrors: Error {
    case unknownRate
    case unavailableFunction
}

typealias RatesDictionary = [Currency : Rate]
typealias Rate = Double

protocol Rater {
    func rate(from: Currency, to: Currency) throws -> Rate
}

extension Rater {
    func rate(from: Currency, to: Currency) throws -> Rate {
        return 1.0
    }
}

protocol ChangeAuthority {
    
    var pattern: Currency { get }
    func patternTo(currency: Currency) -> Rate
    func currencyToPattern(_ currency: Currency) -> Rate
    func value(OfCurrency currency: Currency) -> Rate?
    
}

