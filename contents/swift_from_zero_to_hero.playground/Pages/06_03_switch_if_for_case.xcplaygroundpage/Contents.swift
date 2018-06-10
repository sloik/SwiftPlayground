//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Switch / If Case oraz For Case / Optional binding / Optional Pattern Matching
import Foundation

/*:
 Wykorzystamy w dalszej części rozszerzenie na słowniku, które dla danej wartości zwróci listę wszystkich kluczy, które posiadają tą wartość.  Nie będziemy się teraz wgryzać w to jak działa bo nie jesteśmy na to jeszcze gotowi, ale zobaczymy jak możemy tego używać.
 */
extension Dictionary where Value : Equatable {
    // to jest brzydki kod aby przykłady były ładniejsze ;)
    func key(for val : Value) -> Key {
        filter ({ (_, value) in value == val })
            .map ({ $0.key })
            .first!
    }
}

let kosci = [1: "⚀", 2: "⚁", 3: "⚂", 4: "⚃", 5: "⚄", 6: "⚅"]
kosci.count

/*:
Rzucamy kością...
 */
var kosc1 = kosci[Int(arc4random_uniform(UInt32(kosci.count)) + 1)]!

/*:
 Ponieważ w zmiennej `kosc1` mamy coś co byśmy pokazywali a potrzebujemy informacji o liczbie oczek aby móc liczyć punkty. To wykorzystamy dopiero co stworzone rozszerzenie. O rozszerzeniach opowiemy innym razem.
 */
kosci
    .key(for: kosc1)

/*:
 Więc potrafimy dostać się do informacji ile dana kość jest warta w punktach. Teraz to samo dla drugiej kości...
 */
var kosc2 = kosci[Int(arc4random_uniform(UInt32(kosci.count)) + 1)]!
kosci.key(for: kosc2)

/*:
 # Switch
 
 Instrukcja `Switch` w Swift jest bardziej czytelną wersją wielu występujących po sobie instrukcji `if else`. Co więcej pozwala na wykorzystanie _pattern matching_-u aby lepiej wyrazić intencje w kodzie.
 
 W switch-u `case`y są sprawdzane od góry do dołu. Dlatego najlepiej zaczynać od **najbardziej** szczegółowych i przechodzić do mniej szczegółowych. Do tego kompilator wymusza aby **wszystkie** możliwe kombinacje zostały obsłużone. To sprawia, że ta instrukcja jest bezpieczna.
 
 Jednak kompilator też nie zawsze jest w stanie stwierdzić czego dokładnie brakuje. I jest specjalne słowo kluczowe `default`, które switch wykona jeżeli żaden z innych przypadków nie mógł być dopasowany. Można je pominąć **tylko** gdy kompilator jest w stanie _udowodnić_, że wszystkie ścieżki zostały obsłużone.
 
 Więc rzuciliśmy kostkami. Warto zobaczyć ile  zdobyliśmy punktów...
 */

switch (kosc1, kosc2) {

//default:
    //    break // 💥

case ("⚀", "⚀"): // (1, 1) dokładny wzorzec
    fallthrough  // kontynuuj wykonywanie kolejnego case-a

    
 // można zapisać też: case ("⚀", "⚀"), ("⚅", "⚅"):
case ("⚅", "⚅"):
    "30 punktow"

    
    // Dzięki pattern matching-owi możemy określić zakresy
case ("⚀"..."⚁", "⚀"..."⚁"):
    "16 punktow"
    

    // `_` mówi, że nie interesuje nas "wzorzec" ale możemy "filtrować" to
    // dopasowanie instrukcją `where`. I tak w tym przypadku mówię, że
    // kod ma się wykonać gdy suma wyrzuconych oczek jest `7`
case _ where kosci.key(for: kosc1) + kosci.key(for: kosc2) == 7:
    "5 punktow"

    
    
    // Jak wcześniej ale tym razem warunkiem jest to, że liczba
    // oczek jest taka sama na obu kościach.
case (_, _) where kosc1 == kosc2:
    
    let wartosc = kosci.key(for: kosc2)

    // Jeżeli podwojona wartość oczek to 4 lub 10 to dostaje 8 punktów.
    // W każdym innym przypadku to 10 punktów.
    switch wartosc * 2 {
    case 4, 10:
        "8 punktow"
    default:
        "10 punktow"
    }

    
    // Nie miały zastosowania, żadne inne zasady więc liczba punktów
    // to suma oczek wyrzuconych kości.
default:
    let wartosc1 = kosci.key(for: kosc1)
    let wartosc2 = kosci.key(for: kosc2)

    "\(wartosc1 + wartosc2) punktow"
}

//: Można też __switchować__ po klasach

class Pierwsza {}
class Druga    { var licznik = 42 }
class Trzecia  { var temperatura = 24 }

var jakasInstancja: AnyObject = Trzecia()

switch jakasInstancja {

//: __podłoga__ jeżeli nie potrzebuje odwołać się do zmiennej
case _ as Pierwsza: 
    "pierwsza"

case let typ as Druga:
    type(of: typ)
    typ.licznik

case let typ as Trzecia:
    typ.temperatura
    typ.temperatura = 69
    typ.temperatura

default:
    break;
}

jakasInstancja.description


//: ### If Case oraz For Case
enum Opcje {
    case calkowita(Int)
    case zmiennoPrzecinkowa(Double)
    case textowa(String)
}

let jakasClakowita = Opcje.calkowita(42)

//: W sytuacji gdy chcemy coś zrobic z saną stałą/zmienną możemy wykorzystać __switch__

switch jakasClakowita {
case .calkowita(let calkowita):
    "Hura dla całkowitej \(calkowita)"
case .zmiennoPrzecinkowa:
    break
case .textowa:
    break;
}

// można też nieco to skrócić i zapisać tak:

switch jakasClakowita {
case .calkowita(let calkowita):
    "Hura dla całkowitej \(calkowita)"

default:
    break;
}

//: #### if case

if case .calkowita(let liczbaCalkowita) = jakasClakowita {
     "Hura dla całkowitej \(liczbaCalkowita)"
}

if case .calkowita(let liczbaCalkowita) = jakasClakowita , liczbaCalkowita > 40 {
    "Hura dla całkowitej \(liczbaCalkowita)"
}

//: #### for case
let jakiesOpcje: [Opcje] = [ .calkowita(42), .zmiennoPrzecinkowa(6.9), .textowa("sto"), .calkowita(69)]

for opcja in jakiesOpcje {
    switch opcja {
    case .calkowita(let liczbaCalkowita):
        "Hura dla całkowitej \(liczbaCalkowita)"
    default:
        break
    }
}

for case .calkowita(let liczbaCalkowita) in jakiesOpcje {
    "Hura dla całkowitej \(liczbaCalkowita)"
}

//: podobnie jak wczesniej możeby dodatkowo zacieśniać zakres ktory nas interesuje przy pomocy słowa kluczowego __where__
for case .calkowita(let liczbaCalkowita) in jakiesOpcje where liczbaCalkowita < 69 {
    "Hura dla całkowitej \(liczbaCalkowita)"
}

let procentAlko: Int? = 40

//: #### Optional binding
if let procent = procentAlko , procent >= 34 {
    "Można pić bez obawień"
}

//: #### [Optional pattern matching](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Patterns.html#//apple_ref/doc/uid/TP40014097-CH36-ID520)
if case let procent? = procentAlko , procent >= 34 { // bez '?` będzie Int?
     "Można pić bez obawień"
    type(of: procent)
}

let procenty: [Int?] = [42, nil, 5, nil, 12]

for case let procent? in procenty where procent > 5 {
    procent
}

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
