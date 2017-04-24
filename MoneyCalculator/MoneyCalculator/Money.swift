import Foundation

typealias Currency = String

protocol Money {
    
    init(_ amount: Double, currency: Currency)
    
    mutating func times(_ times: Double) -> Self

    func plus(_ sum: Self) -> Self

    func reduced(to currency: Currency, broker: Broker) -> Self
}
