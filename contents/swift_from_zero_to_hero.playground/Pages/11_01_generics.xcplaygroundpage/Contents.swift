//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Generyki](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html)

import Foundation

/*:
W Swift każda stała lub zmienna mają zadeklarowany typ. Dzięku temu zawsze (prawie zawsze) wiemy z jakiego _typu_ obiektem mamy do czynienia. Gdy potrzebujemy nieco rozluźnić "więzy" możemy zadeklarować zmienną jako _Any_ lub _AnyObject_. Dodatkowo mając protokoły znamy interfejs danego typu i możemy bezpiecznie wywoływać na nim metody. Jeżeli natomiast mamy potrzebę sprawdzenia z jakim konkretnie typem teraz pracujemy możemy zkastować na odpowiedni typ (oczywiście wymaga to sprawdzenia czy instancja z którą teraz pracujemy jest tego typu). **Generyki** pozwalają nam zachować "gwarancje typu" i pozwalają nam pracować bezpośrednio z instancją bez wymogu kastowania (ang. cast).

Kilka przykładów:
*/

let strings: Array<String> = []
type(of: strings)

let ints: Array<Int> = []
type(of: ints)

struct 💩 { var id: Int  }

//: 💡: Zobacz jak zadeklarowana jest tablica w standardowej bibliotece (cmd + double click)

let 💩s: Array<💩> = []
type(of: 💩s)

/*:
Wygląda na to, że już zupełnie niechcący generyki były wykorzystywane na potęgę i nawet o tym nie wiedzieliśmy!
*/

let dictionaryOfStringInt: Dictionary<String, Int> = [:] //💡: Więcej jak jeden typ (argument) generyczny
type(of: dictionaryOfStringInt)

let setOfStrings: Set<String> = []
type(of: setOfStrings)

run("🤽‍♂️ swap"){
    var foo      = 4  ;  var bar      = 2
    var floatFoo = 4.2;  var floatBar = 6.9
    
    print("Przed", foo, bar, floatFoo, floatBar)
    
    swap(&foo , &bar )
    swap(&floatFoo, &floatBar)
    
    print("   Po", foo, bar, floatFoo, floatBar)
}

/*:
 Optional to też generyk!
 */
 
let maybeQuote: Optional<String> = .none

/*:
 ## Własne Generyki
 
 Do definiowania własnych typów, które są generyczne wykorzystujemy składnię `<Token>` (tyczy się to typów i funkcji/metod). Gdzie `Token` jest dowolnym string-iem po którym się odwołujemy do konkretnego i zawsze tego samego typu. Array używa nazwy `Element`, Optional `Wrapped` etc. Często też można się spotkać z jedno literowymi oznaczeniami `T`, `U` itd.
 */


run("🧩 custom") {

    final class Wrapper< Wrapped > {
        var wrap: [Wrapped]

        init(wrap: [Wrapped]) { self.wrap = wrap }

        func random() -> Wrapped { wrap.randomElement()! }
    }

    let numbers  = [4, 2, 6, 9]
    let strings = ["Można", "pić", "bez", "obawień"]

    let numberWrapper  = Wrapper(wrap: numbers)
    let stringsWrapper = Wrapper(wrap: strings)

    let _: Int = numberWrapper.random()
    
    let _: String = stringsWrapper.random()
}

/*:
 
 Wrapper przechowuje _coś_ typu `Wrapped`. Nie wiemy co to jest. Nie można zawołać na tym żadnej metody czy sprawdzić property. Wiemy tylko tyle _że jest_.
 
 Jeżeli byłoby więcej typów generycznych to by były zdefiniowane po przecinku np. `class Wrapper <X,Y,Z>`. W tym przykładzie są trzy typy generyczne. Każdy z nich pozwala wstawić inny konkretny typ np. `Wrapper<Int, String, Float>`. Nie musi tak być ta sama definicja (X,Y,Z) zadziała dla `Wrapper<Int, Int, Int>`. Jedyne co to mówi to, że jest taka możliwość a nie obowiązek.

 ## Ograniczanie Generyków
 
 Mając typ o którym nic nie wiemy i nic z nim nie możemy zrobić może być plusem a może czasem wiązać ręce. Czasem chcemy pracować z instancją czegoś co ma jakieś właściwości i/lub metody lub konformuje do protokołu.
 
 Istnieje składnia, która pozwala na nałożenie dodatkowych ograniczeń co do typu.
 
 */


protocol Skaczacy   {}
protocol Spiewajacy {}

xrun {

    final class Wrapper< Wrapped > where Wrapped: Skaczacy, Wrapped: Spiewajacy  {
        var wrap: [Wrapped]

        init(wrap: [Wrapped]) { self.wrap = wrap }

        func random() -> Wrapped { wrap.randomElement()! }
    }

    struct GrajekSkaczacy      : Skaczacy             {}
    struct GrajekSpiewajacy    : Spiewajacy           {}
    struct MurarzPiekarzAkrobata: Skaczacy, Spiewajacy {} // 👍🏻

    let skaczacyGrajkowie   = [GrajekSkaczacy(), GrajekSkaczacy()]
    let spiewajacyGrajkowie = [GrajekSpiewajacy(), GrajekSpiewajacy()]
    let artysci             = [MurarzPiekarzAkrobata(), MurarzPiekarzAkrobata()]

//    let sreberko1 = Wrapper.init(wrap: skaczacyGrajkowie) // 💥
//    let sreberko2 = Wrapper.init(wrap: spiewajacyGrajkowie) // 💥
    let sreberko3 = Wrapper(wrap: artysci)
    let coTuMamy = sreberko3.random()
    type(of: coTuMamy) // 💡: bardzo intrygujacy typ... może wyrostek?

}




//: ## [Generyki w Protokołach / Associated Types](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID189)

protocol Zawijacz {
    associatedtype JakiTypZawijam

    var ileJuzZawinieto: Int { get }
    mutating func zawin(element: JakiTypZawijam)
}


class Swistak<ToZawijam>: Zawijacz {

    typealias JakiTypZawijam = ToZawijam

    var zawiniatka: [ToZawijam]

    init(element: ToZawijam) {
        zawiniatka = [element]
    }

    var ileJuzZawinieto: Int { return zawiniatka.count }
    func zawin(element: JakiTypZawijam) {
        zawiniatka.append(element)
    }
}

let swistakIntow = Swistak.init(element: 4)
type(of: swistakIntow)
swistakIntow.zawin(element: 2)
swistakIntow.ileJuzZawinieto
swistakIntow.zawiniatka
type(of: swistakIntow.zawiniatka.first!)

let swistakStringow = Swistak.init(element: "Można")
type(of: swistakStringow)
swistakStringow.zawin(element: "pić")
swistakStringow.zawin(element: "bez")
swistakStringow.zawin(element: "obawień")
swistakStringow.ileJuzZawinieto
swistakStringow.zawiniatka
type(of: swistakStringow.zawiniatka.first!)

//: Okazuje się, że jeżeli kompilator jest w stanie wydedukować typ to to zrobi dzięki czemu nie musimy definiować tego aliasu.

protocol Zaskakujacy {
    associatedtype ElementZawijany

    mutating func zapamietajCos(cos: ElementZawijany)
    func dajCos() -> ElementZawijany?
}

struct CoZaGosc<GMO>: Zaskakujacy {
    var coski: [GMO] = []

    init(startowy: GMO) {
        zapamietajCos(cos: startowy)
    }

    mutating func zapamietajCos(cos: GMO) {
        coski.append(cos)
    }

    func dajCos() -> GMO? {
            return coski.last
    }
}

var aleJaja = CoZaGosc(startowy: 4)
type(of: aleJaja)
aleJaja.zapamietajCos(cos: 4)
aleJaja.zapamietajCos(cos: 2)
aleJaja.coski


var jakiZdolny = CoZaGosc(startowy: "mozna")
type(of: jakiZdolny)
jakiZdolny.zapamietajCos(cos: "pic")
jakiZdolny.zapamietajCos(cos: "bez")
jakiZdolny.zapamietajCos(cos: "obawien")
jakiZdolny.coski
//: Ten mechanizm jest wykorzystywany bardzo często w standardowej bibliotece Swift-a.

let tablica: Array<String> = []

//: Ta cała magia pozwala na prace z tablicą bez wymuszania kastowania.
// 💡Array
//     Array<Element> : CollectionType, MutableCollectionType, _DestructorSafeContainer ...
// 💡CollectionType
    // typealias Generator : GeneratorType = IndexingGenerator<Self> // 😱
// 💡GeneratorType
    /// The type of element generated by `self`.
    //typealias Element

print("🦄")

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)


