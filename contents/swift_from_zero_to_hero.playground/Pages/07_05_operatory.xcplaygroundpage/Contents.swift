//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Operatory
//: Operatory w Swift są po prostu globalnymi (nie należącymi do żadnej Struktury lub Klasy) funkcjami. 
import UIKit

6 + 9 // klikamy z altem na "+" lub z cmd aby zobaczyć cala listę

//: Możemy nawet taki operator przypisać do zmiennej jednak musimy podać konkretny "wariant przeciążenia" aby kompilator wiedział o którą wersje nam chodzi.

let adder: (Int, Int) -> Int = (+)
adder(6,9)

/*:
## [Własne Operatory](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AdvancedOperators.html#//apple_ref/doc/uid/TP40014097-CH27-ID46)
Operatory mogą się zaczynać od znaków: .., /, =, -, +, !, *, %, <, >, &, |, ^, ?, ~

[Dokumentacja](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID418)
*/

let pointA = CGPoint(x: 6, y: 9)
let pointB = CGPoint(x: 4, y: 2)

/*:
[Dokumentacja](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AdvancedOperators.html#//apple_ref/doc/uid/TP40014097-CH27-ID41)

> Operator __precedence__ gives some operators higher priority than others; these operators are applied first.

Operator __associativity__ defines how operators of the same precedence are grouped together—either grouped from the left, or grouped from the right. Think of it as meaning “they associate with the expression to their left,” or “they associate with the expression to their right.”
*/

//: [Mechanizm zastępujący numeryczne wartości](https://github.com/apple/swift-evolution/blob/master/proposals/0077-operator-precedence.md)
precedencegroup MadeUpName {
    higherThan: AdditionPrecedence
    lowerThan: BitwiseShiftPrecedence
    associativity: left
}

infix operator -<==>- : MadeUpName
extension CGPoint {
    static func -<==>- (left: CGPoint, right: CGPoint) -> Bool {
        (left.x == right.x) && (left.y == right.y)
    }
}

pointA -<==>- pointB
pointA -<==>- pointA

//: ## Operator Wyrażeń / [Pattern-Matching Operator](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Patterns.html#//apple_ref/doc/uid/TP40014097-CH36-ID426)

42 ~= 42 // domyślnie używa operatora "=="

/*:
 W obecnej sytuacji nie możemy sprawdzić czy Int 42 jest równoważny String "42".
 */

// Cannot convert value of type 'Int' to expected argument type 'Substring';
//42 ~= "42"

/*:
 Możemy to zrobić definiując operator `~=`. Jest to zwykła funkcja o może nieco dziwnej nazwie.
 */


func ~=(number: Int, text: String) -> Bool {
    "\(number)" == text
}

// Now it compiles just fine!
42 ~= "42"

/*:
 Operator pattern matchingu można wykorzystać nawet w zwykłym `if`ie:
 */

for i in 0...10 {
    if 3...6 ~= i {
        print(i)
    }
}

/*:
 Przy każdej iteracji pada pytanie czy `i` jest w zakresie `3..6`. W tajemnicy powiem, że dzięki temu operatorowi pattern matching działa w instrukcji `switch`. Zakomentuj definicję funkcji dla tego operatora i zobacz jaki będzie błąd.
 */

switch "33" {
case 33: print("😎")
default: print("🙈")
}

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
