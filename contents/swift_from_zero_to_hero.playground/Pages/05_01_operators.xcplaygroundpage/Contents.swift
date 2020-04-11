//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## [Operatory](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AdvancedOperators.html) (arytmetyczne, porównanie, rzutowanie, zakresy)
/*:
 * [🇵🇱 Swift od zera do bohatera! Operatory Arytmetyczne oraz Przepełnienia](https://www.youtube.com/watch?v=3psYUMdYNjs&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=14)
 
  * [🇵🇱 Swift od zera do bohatera! Swift Operatory do Porównywania oraz Boolowskie](https://www.youtube.com/watch?v=FRqDiD5uArk&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=15)
 
   * [🇵🇱 Swift od zera do bohatera! Ternary Operator, Range oraz ich wykorzystanie](https://www.youtube.com/watch?v=y0QteeCJ2cI&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=16)
 
  * [🇵🇱 Swift od zera do bohatera! Rzutowanie (Cast) operacje na bitach oraz kolejność działań](https://www.youtube.com/watch?v=jBdWJHHlUIE&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=17)
 */

import UIKit

//: ## Operatory Arytmetyczne

2 + 3
2 - 3
2 * 3
2 / 3 // -> Int
2 / 3.0

var mniejszeZlo = 665
mniejszeZlo += 1
mniejszeZlo -= 1
mniejszeZlo

var a = 6.9
a -= 1
a += 1
a

var b = 2
b += 3
b -= 3
b *= 3
b /= 3

10 % 9
10 % -9
-10 % 9
-10 % -9

//: Miła niespodzianka "modulo" działa też na liczbach zmiennoprzecinkowych.
10.5.truncatingRemainder(dividingBy: 9)

//: ### Przepełnienia / Overflow

var intMax : UInt8 = UInt8.max
String(intMax, radix: 2)
//intMax + 1 // 💥
intMax &+ 1

var intMin : Int8 = Int8.min
String(intMin, radix: 2)
intMin &- 1

var intJakis : UInt8 = 160
intJakis &* 2

//: Jak już było pokazane w rozdziale o stringach operator + możemy też i dla nich zastosować.

"Lorem" + " " + "ipsum"

//: Tablice też...

[1,2,3] + [4, 5, 6]

//: ### Porównania i operatory logiczne

let intA = 2
let intB = 6
var intJakisInny = intA

let instancjaA = Wartosc()
let instancjaB = Wartosc()
let instancjaJakas = instancjaA

intA == intJakisInny // czy ta sama wartosc
intA != intB

instancjaA == instancjaB // czy obiekty sa rowne 'func ==' // inny kolor i można nadusić z altem dla opisu
instancjaA === instancjaB
instancjaA === instancjaJakas // czy ten sam obiekt

Unmanaged.passUnretained(instancjaA).toOpaque()
Unmanaged.passUnretained(instancjaJakas).toOpaque()
Unmanaged.passUnretained(instancjaB).toOpaque()

var prawda = true
!prawda

//: Operatory logiczne sa ewaluowane od lewej do prawej. Dlatego lepiej te wymagające mniej obliczeń dać jako pierwsze.

// AND
true && true
true && false

// OR
true || true
true || false

//: ### Operator Trójargumentowy (test/warunek) ? TAK : NIE

let warunek = true

/*:
 Zamiast pisać `if else`...
 */
if warunek {
    "Warunek spełniony"
} else {
    "Warunek nie spełniony"
}

/*:
 Możemy to zapisać gęściej :)
 */
let cos = warunek ? "Warunek spełniony"
                  : "Warunek nie spełniony"

/*:
 ### Nil Coalescing (Elvis ?:)
 Pewne operacje w kodzie są tak powszechne, że dostają specjalną składnie. Zobaczmy co nam upraszcza _nil coalescing_ znany z innych języków jako "elvis" `?:`
 */

//: wersja `if else`
run {
    let ostatecznaOdpowiedz: String
    let domyslnaOdpowiedz: String = "Tak"

    let opcjonalnaOdpowiedz: String? = .none
//    let opcjonalnaOdpowiedz: String? = "Może jednak nie"
   
    if opcjonalnaOdpowiedz != .none {
        ostatecznaOdpowiedz = opcjonalnaOdpowiedz!
    } else {
        ostatecznaOdpowiedz = domyslnaOdpowiedz
    }

    ostatecznaOdpowiedz
}

/*:
 Zaletą tego kodu jest to, że działa ;) Ostateczna odpowiedź jest wypełniona. Natomiast dość trudno jest śledzić okiem jak co działa. Możemy troche lepiej:
 */

//: Wersja z `?:`
run {
    let domyslnaOdpowiedz: String = "Tak"
    
    let opcjonalnaOdpowiedz: String? = .none
//    let opcjonalnaOdpowiedz: String? = "Może jednak nie"
    
    let ostatecznaOdpowiedz: String =
        opcjonalnaOdpowiedz != .none ? opcjonalnaOdpowiedz! : domyslnaOdpowiedz
    
    ostatecznaOdpowiedz
}
/*:
 Wizualnie kod jest mniej poszatkowany. Łatiej coś takiego się czyta i łatwiej odgadnąc intenje autora: _jeżeli coś jest w opcjonalnej odpowiedzi to użyj tej wartości, jak nie to użyj domyślnej_.
 
 Jest tak powszechna operacja, że ma swój własny cukier składniowy właśnie w formie _nil coalescing_ operatora `??`
 */
//: Wrsja z `??`
run {
    let domyslnaOdpowiedz: String = "Tak"
    
    let opcjonalnaOdpowiedz: String? = .none
//    let opcjonalnaOdpowiedz: String? = "Może jednak nie"
    
    let ostatecznaOdpowiedz: String = opcjonalnaOdpowiedz ?? domyslnaOdpowiedz
    
    ostatecznaOdpowiedz
}
/*:
 Dużo zwięźlej i bardziej czytelny kod, lepiej niosący _intencję_ autora.
 */
//: ## Zakresy (Range) -> Sekwencje Wartości
/*:
 Zdarza się, że chcemy pracować z wartoścoami z jakiegoś zakresu (od 5 do 15). Swift ma specjalny typ, który nam to umożliwia i specjalną składnie, która to nieco ułatwia.
 */
for element in 0..<8 {
    element
}

/*:
 Zakresy mogą być "pół otwarte" oraz "zamknięte". Pół otwarty to taki gdzie górna granica do niego nie należy np. od 0 do 10 ale bez 10. Zamknięty zawiera też 10.
 */
let polOtwartyZakres = 0..<10
let zamknietyZakres  = 0...10

//polOtwartyZakres == zamknietyZakres // 💥
polOtwartyZakres == polOtwartyZakres
0..<44 == 0..<43

let dziwneCudo = ...42
print(dziwneCudo)

//: Stringi

var nowszyCytat = "Można pić bez obawień."

let poczatkowyIndex = nowszyCytat.index(nowszyCytat.startIndex, offsetBy: 6);
let koncowyIndexZakresu = nowszyCytat.index(poczatkowyIndex, offsetBy: 3)
let zakres = poczatkowyIndex..<koncowyIndexZakresu
type(of: zakres)


for indexOfLetter in nowszyCytat.indices[nowszyCytat.startIndex..<nowszyCytat.endIndex] {
    nowszyCytat[indexOfLetter]
}

// można też krócej
for indexOfLetter in nowszyCytat.indices[..<nowszyCytat.endIndex] {
    nowszyCytat[indexOfLetter]
}

for letter in nowszyCytat {
    print(letter)
}

nowszyCytat
nowszyCytat.replaceSubrange(zakres, with: "chlać")

//: Tablice

var liczby: [Int] = []
for index in 0..<5 {
    liczby += [index]
}
liczby

var doZastapienia = [11, 12, 13, 14, 15, 16]

let zakresDoZastapienia = (liczby.startIndex + 1) ..< (liczby.endIndex - 1) // 1..<4
liczby[zakresDoZastapienia]

liczby.replaceSubrange(zakresDoZastapienia, with: doZastapienia)

//: ## Rzutowanie

class Roslina       { var property1 = 1 }
class Owoc: Roslina { var property2 = "Wieslaw Wszywka" }
class Mieso {}

let k1 = Roslina()
let k2 = Roslina()

let tablica = [k1, k2]
type(of: tablica)

let pierwszyElement = tablica[0]
type(of: pierwszyElement)

pierwszyElement.property1

let drugiElement = tablica[1] // będzie typu Roslina
type(of: drugiElement)
//drugiElement.property2 // 💥

drugiElement is Owoc

// 'force cast' lub 'down cast'
run {
    NSSetUncaughtExceptionHandler{print("💥 Exception thrown: \($0)")}
//    let instancjaRosliny = drugiElement as! Owoc // Could not cast value of type 'Roslina' to 'Owoc'
    let instancjaRosliny = drugiElement as? Owoc // sprawdzic bez !
    
    //instancjaRosliny?.property2
    
    // 'upcast'
    
    let owoce: [Owoc] = [Owoc()]
    let owocUzywanyJakRoslina = owoce[0] as Roslina
//    owocUzywanyJakRoslina.property2 // Value of type 'Roslina' has no member 'property2'
    type(of: owocUzywanyJakRoslina)
    
    let tablicaRozmaitosci: [AnyObject] = [k1, k2, Mieso()];
    type(of: tablicaRozmaitosci)
    
    let zdecydowanieInstancjaRoslina = tablicaRozmaitosci[0] as! Roslina
    let bycMozeInstancjaRoslina = tablicaRozmaitosci[1] as? Roslina
    type(of: bycMozeInstancjaRoslina)
    bycMozeInstancjaRoslina?.property1
    
    // rzutowanie inline
    (tablicaRozmaitosci[1] as? Owoc)?.property2
}

//: ## Operacje na Bitach

let jeden      = 0b1             // 00000001
let dwa        = jeden << 1      // 00000010
let cztery     = jeden << 2      // 00000100
let szesnascie = jeden << 4      // 00010000
let osiem      = szesnascie >> 1 // 00001000

printBinnary(jeden)
printBinnary(dwa)
printBinnary(cztery)
printBinnary(szesnascie)
printBinnary(osiem)

let zero: UInt8 = 0b00000000    // 00000000
zero

~zero                           // 11111111

String(~zero, radix: 2)
String(~zero, radix: 10)
String(~zero, radix: 16)


UInt8.max == ~zero

let binarnaA = 0b1100
let binarnaB = 0b1010
String(binarnaA, radix: 2)
String(binarnaB, radix: 2)

String(binarnaA & binarnaB, radix: 2)       // AND
String(binarnaA | binarnaB, radix: 2)       // OR
"0" + String(binarnaA ^ binarnaB, radix: 2) // XOR


// Bitmaska tak jak w Objective C
let opcja1 = 0b001
let opcja2 = 0b010
let opcja3 = 0b100
String(opcja1 | opcja2 | opcja3, radix: 2)

//: ## Kolejność wykonywania działań [Precedence and Associativity](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AdvancedOperators.html#//apple_ref/doc/uid/TP40014097-CH27-ID41)

let wynik1: Double =  1 +    2 * 3  / 4    // wersja bez nawiasow
let wynik2: Double = (1 + (((2 * 3) / 4))) // rownowazna wersji z nawiasami

2 + 2 * 2
(2 + 2) * 2

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)

