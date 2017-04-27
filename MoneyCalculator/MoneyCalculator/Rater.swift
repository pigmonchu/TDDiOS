import Foundation

enum BrokerErrors: Error {
    case unknownRate
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

