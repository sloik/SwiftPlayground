//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Operatory
//: Operatory w Swift są po prostu globalnymi (nie należącymi do żadnej Struktury lub Klasy) funkcjami. 
import UIKit

6 + 9 // klikamy z alt/option na "+" lub z cmd aby zobaczyć cala listę

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

 # Definiowanie Operatorów
 
 Tworząc własny operator trzeba określić kilka rzeczy:
 
 * w jakiej kolejności mają być wykonywane różne operatory (precedence),
 * w jakiej kolejności mają być wykonywane te same operatory (associativity),
 * w którym _miejscu_ ma być użyty operator (prefix, infix, postfix)
 
 Do określania kolejności wykonywania różnych operatorów służy [`precedencegroup`](https://github.com/apple/swift-evolution/blob/master/proposals/0077-operator-precedence.md).
 */

precedencegroup PointComperatorPrecedence {
    higherThan: AdditionPrecedence
    lowerThan: BitwiseShiftPrecedence
    associativity: left
}

/*:
 To co musimy zrobić to nadać jakąś nazwę tej grupie. Dzięki temu zawsze można _wepchnąć_ kolejną grupę pomiędzy już istniejące.
 
 Następnie określamy czy ma być wykonywana przed `higherThan` innym operatorem czy po `lowerThan`. Nie zawsze podawanie górnej i dolnej granicy jest potrzebne. I tak wyrażenie `2 + 2 * 2` powinno dać `6` ponieważ `*` jest _higherThan_ `+`. W bardziej skomplikowanych przypadkach polecam pisać nawiasy `2 + (2 * 2)`. Może i trochę więcej znaczków ale nie ma żadnych niedomówień.
 
 Ostatni krok to określenie co ma się wydarzyć w sytuacji gdy ten sam operator jest użyty w jednym wyrażeniu. Upraszczając troszeczkę to można powiedzieć _gdzie w tym wyrażeniu kompilator ma wstawić nawiasy_ (nie robi czegoś takiego ale można o tym tak pomyśleć). Np. gdy daje komuś instrukcje jak iść na pocztę to jest różnica między `iść prosto i potem w lewo` a `w lewo i iść prosto`.
 
 Wymyślając taki operator `$>` to wyrażenie `prosto $> lewo $> prosto` wskaże inne miejsce gdy w pierwszej kolejności będą brane argumenty _z lewej_ niż w sytuacji gdy będą brane _z prawej_. Sytuacja może być czytelniejsza po wpisaniu nawiasów. I tak _lewo_: ` ( (prosto $> lewo) $> prosto )`, _prawo_: `( prosto $> (lewo $> prosto) )`.
 
 Ostania rzecz to _kształt_ operatora z przypiętą grupą oraz jego implementacja. Czy to statyczna funkcja na typie czy globalna nie ma znaczenia.
 
 `prefix` oznacza, że operator jest użyty na początku wyrażenia. I tu operator negacji `!` na wartości typu Bool jest dobrym przykładem. `postfix` oznacza, że znajduje się na końcu wyrażenia. Takie operatory są jednoargumentowe.
 
 Jednak najczęściej spotykane są operatory typu `infix`. Przyjmują one dwa parametry i występują między argumentami. Mega prostym przykładem jest `+`, `*` i masa innych operatorów.
 */

infix operator -<==>- : PointComperatorPrecedence
extension CGPoint {
    static func -<==>- (left: CGPoint, right: CGPoint) -> Bool {
        (left.x == right.x) && (left.y == right.y)
    }
}

pointA -<==>- pointB
pointA -<==>- pointA

//: ## [Pattern-Matching Operator](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Patterns.html#//apple_ref/doc/uid/TP40014097-CH36-ID426)

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


/*:
 # Podsumowanie
 
 Operatory to **zwykłe funkcje** które można wywołać w niezwykły sposób. Trzeba na nie nieco uważać gdyż jak jest ich za dużo to mogą sprawić, że kod jest trudny do zrozumienia. Jednak użyte odpowiednio sprawiają, że kod staje się bardziej ekspresyjny i zrozumiały.
 
 ## Linki
 
 * [Ray Wenderlich - Custom operators in Swift](https://www.raywenderlich.com/4018226-overloading-custom-operators-in-swift)
 */
//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
