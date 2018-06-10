//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Generyki](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html)

import Foundation

/*:
W Swift każda stała lub zmienna mają zadeklarowany typ. Dzięku temu zawsze (prawie zawsze) wimy z jakiego _typu_ obiektem mamy do czynienia. Gdy potrzebujemy nieco rozluźnić "więzy" możemy zadeklarować zmienną jako _Any_ lub _AnyObject_. Dodatkowo mając protokoły znamy interfejs danego typu i możemy bezpiecznie wywoływać na nim metody. Jeżeli natomiast mamy potrzebę sprawdzenia z jakim konkretnie typem teraz pracujemy możemy skastować na odpowiedni typ (oczywiście wymaga to sprawdzenia czy instancja z którą teraz pracujemy jest tego typu). **Generyki** pozwalają nam zachować "gwarancje typu" i pozwalają nam pracować bezpośrednio z instancją bez wymogu kastowania.

Kilka przykładów:
*/

let tablicaStringow: Array<String> = []
type(of: tablicaStringow)

let tablicaIntow: Array<Int> = []
type(of: tablicaIntow)

struct 💩 { var id:Int  }
//: 💡: Zobacz jak zadeklarowana jest tablica w standardowej bibliotece (cmd + click)
let tablica💩: Array<💩> = []
type(of: tablica💩)

/*:
Wygląda na to, że już zupełnie niechcący generyki były wkorzystywane na potęgę i nawet o tym nie wiedzieliśmy!
*/

let slownikStringInt: Dictionary<String, Int> = [:] //💡: Wiecej jak jeden typ genereyczny
type(of: slownikStringInt)

let setStringowNiemieckich: Set<String> = []
type(of: setStringowNiemieckich)

var foo  = 4;    var bar  = 2
var fFoo = 4.2;  var fBar = 6.9

swap(&foo , &bar )
swap(&fFoo, &fBar)

foo
bar
fFoo
fBar

//: Co i tu też!
let bycMozeCytat: Optional<String> = nil


//: ## Własne Generyki

xrun {

    class Sreberko <TypKtoryZawijam> {

        var zawiniatko: [TypKtoryZawijam]

        init(zawin: [TypKtoryZawijam]) {
            zawiniatko = zawin
        }

        func niespodzianka() -> TypKtoryZawijam {
            let index = Int(arc4random_uniform(UInt32(zawiniatko.count)))
            return zawiniatko[index]
        }
    }

    let liczby  = [4, 2, 6, 9]
    let stringi = ["Można", "pić", "bez", "obawień"]

    let sreberko1 = Sreberko.init(zawin: liczby)
    let sreberko2 = Sreberko.init(zawin: stringi)

    let niespodzianka1 = sreberko1.niespodzianka()
    type(of: niespodzianka1)
    
    let niespodzianka2 = sreberko2.niespodzianka()
    type(of: niespodzianka2)
    
}
//: ## Ograniczanie Generyków
//: Istnieje składnia, która pozwala na nalożenie dodatkowych ograniczeń co do typu.

protocol Skaczacy   {}
protocol Spiewajacy {}

xrun {

    class Sreberko<Typ> where Typ: Skaczacy, Typ: Spiewajacy { // 💡 też zadziała: <Typ: protocol<Skaczacy, Spiewajacy>>

        var zawiniatko: [Typ]

        init(zawin: [Typ]) {
            zawiniatko = zawin
        }

        func niespodzianka() -> Typ {
            let index = Int(arc4random_uniform(UInt32(zawiniatko.count)))
            return zawiniatko[index]
        }
    }

    struct GrajekSkaczacy      : Skaczacy             {}
    struct GrajekSpiewajacy    : Spiewajacy           {}
    struct MurazPiekrzaAkrobata: Skaczacy, Spiewajacy {} // 👍🏻

    let skaczacyGrajkowie   = [GrajekSkaczacy(), GrajekSkaczacy()]
    let spiewajacyGrajkowie = [GrajekSpiewajacy(), GrajekSpiewajacy()]
    let artysci             = [MurazPiekrzaAkrobata(), MurazPiekrzaAkrobata()]

//    let sreberko1 = Sreberko.init(zawin: skaczacyGrajkowie) // 💥
//    let sreberko2 = Sreberko.init(zawin: spiewajacyGrajkowie) // 💥
    let sreberko3 = Sreberko.init(zawin: artysci)
    let coTuMamy = sreberko3.niespodzianka()
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

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)


