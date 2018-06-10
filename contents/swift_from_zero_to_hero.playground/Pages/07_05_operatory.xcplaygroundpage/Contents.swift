//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Operatory
//: Operatory w Swift są po prostu globalnymi (nie należącymi do żadnej Struktury lub Klasy) funkcjami. 
import UIKit

6 + 9 // klikamy z altem na "+" lub z cmd aby zobaczyc cala liste

//: Możemy nawet taki operator przypisać do zmiennej jednak musimy podać konkretny "wariant przeciążenia" aby kompilator wiedział o którą wersje nam chodzi.

let dodawacz: (Int, Int) -> Int = (+)
dodawacz(6,9)

/*:
## [Własne Operatory](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AdvancedOperators.html#//apple_ref/doc/uid/TP40014097-CH27-ID46)
Operatory mogą się zaczynać od znaków: .., /, =, -, +, !, *, %, <, >, &, |, ^, ?, ~

[Dokumentacja](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID418)
*/

let punktA = CGPoint(x: 6, y: 9)
let punktB = CGPoint(x: 4, y: 2)

/*:
[Dokumentacja](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AdvancedOperators.html#//apple_ref/doc/uid/TP40014097-CH27-ID41)

> Operator __precedence__ gives some operators higher priority than others; these operators are applied first.

Operator __associativity__ defines how operators of the same precedence are grouped together—either grouped from the left, or grouped from the right. Think of it as meaning “they associate with the expression to their left,” or “they associate with the expression to their right.”
*/

//: [Mechanizm zastępujący numeryczne wartości](https://github.com/apple/swift-evolution/blob/master/proposals/0077-operator-precedence.md)
precedencegroup Wymyslona {
    higherThan: AdditionPrecedence
    lowerThan: BitwiseShiftPrecedence
    associativity: left
}

infix operator -<==>- : Wymyslona
extension CGPoint {
    static func -<==>- (lewa: CGPoint, prawa: CGPoint) -> Bool {
        return (lewa.x == prawa.x) && (lewa.y == prawa.y)
    }
}

punktA -<==>- punktB
punktA -<==>- punktA

//: ## Operator Wyrażeń / [Pattern-Matching Operator](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Patterns.html#//apple_ref/doc/uid/TP40014097-CH36-ID426)

42 ~= 42 // domyślnie uzywa operatora "=="

//42 ~= "42"

//func ~=(liczba: Int, text: String) -> Bool {
//   return "\(liczba)" == text
//}

for i in 0...10 {
    if 3...6 ~= i {
        print(i)
    }
}

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
