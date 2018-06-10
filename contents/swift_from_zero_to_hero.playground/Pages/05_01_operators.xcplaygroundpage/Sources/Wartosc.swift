import Foundation

public func ==(lhs: Wartosc, rhs: Wartosc) -> Bool {
    return lhs.przechowywanaLiczba == rhs.przechowywanaLiczba
}

open class Wartosc {
    open var przechowywanaLiczba = 42
    public init () {}
}

public func printBinnary(_ i: Int) -> String {
    let binStr: String = String(i, radix: 2)
    let binRev = String(binStr.reversed())
    let padded = binRev.padding(toLength: 8, withPad: "0", startingAt: 0)
    return String(padded.reversed())
}
