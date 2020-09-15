//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
/*:
## Enumeration [dokumentacja](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html)
W Swift **enumeracje** to dużo bardziej uzyteczny i funkcjonalny typ niż w innych językach (C/ObjC). Dzięki nim możemy grupować powiązane ze sobą wartości (kierunki świata, zestawy kolorów, błędy HTTP etc.). Każda z tych wewnętrznych nazwanych wartości nosi nazwę "członek" (ang. member) 😎. Ponieważ **są typem** wartościowym to są przekazywane przez kopie.

Enumeracje **mają**:
* wyliczeniowe właściwości na instancji
* "normalne" i wyliczeniowe właściwości na Typie Enumeracji
* initializery
* metody
* mogą wspierać subskrypty (notację z nawiasikiem [])
* adopotowac protokoły

Enumeracje **nie mają**:
* właściwości na instancji enumeracji
* dziedziczenia

*/

enum Color {
    case pretty
    case ugly
    case veryUgly
}

let prettyColor = Color.pretty
type(of: prettyColor)

func whatsTheColor(_ input: Color) {
    "Kolor jest: \(input)"
}

whatsTheColor(prettyColor)

/*:
 Można zdefiniować enumeracje konkretnego typu. Możemy się też odwołać do wartości przechowywanej przez dany case korzystając z właściwości **rawValue**.
 
 W przypadku gdy enumeracja posiada _rawValue_ oraz jej typ to `Int`, kompilator zacznie przypisywać wartości od `0`. Jeżeli gdzieś w trakcie _przeskoczy_ się te wartości to kompilator będzie numerować _dalej_.
 */

enum CountingOut: Int {
    case eney // 0
    case meeny = 5
    case miny, moe, catchATiger = 20, byTheToe // 6, 7, 20, 21
}

enum Overcast: String {
    case storm      = "⛈"
    case shitStorm  = "💩⚡️"
    case rain       = "🌧"
    case clearSky   = "☀️"
}

let someOvercast = Overcast.storm
type(of: someOvercast)
someOvercast.rawValue

let whatCountedOut = CountingOut.moe
type(of: whatCountedOut)
whatCountedOut.rawValue

//: Możemy stworzyć instancję enumeracji korzystając z jej "surowej wartości" (jeżeli ją znamy) ;)

var whatCountedOutRawValue = CountingOut(rawValue: 21) // 💡 rawValue: 42
type(of: whatCountedOutRawValue)
if let _ = whatCountedOutRawValue {
    whatCountedOutRawValue!
} else {
    whatCountedOutRawValue
}

var overcastRawValue = Overcast(rawValue: "💩⚡️")
type(of: overcastRawValue)
if let _ = overcastRawValue {
    overcastRawValue!
} else {
    overcastRawValue
}

//: "Casy" mogą być użyte jako klucze w słownikach.

let whatToWear: [Overcast: String] = [
    .storm      : "Siedź w domu i bój się gromu!",
    .shitStorm  : "Kalosze, parasole i trzeźwiące sole!",
    .rain       : "Na deszcz nie da rady!",
    .clearSky   : "Leż na plaży i opalaj się na wznak!"
]

run("🐸 what to wear") {
    for (overcast, what) in whatToWear {
        print("\(overcast):\t\t\(what)")
    }
}

/*:
 ## Initializery Oraz Metody na Enumie
 
 Enumeracje nie różnią się za dużo od _zwykłych_ klas czy struktur. Co za tym idzie można na nich definiować metody oraz property. Dzięki temu można tworzyć bardziej ergonomiczne API do ich konsumowania.
 
 Przy okazji konsumpcji enumeracji. Często zachodzi potrzeba przejścia _po każdym case_ lub po prostu odpowiedzenia na pytanie _ile ich jest?_. W tym momencie przychodzi z pomocą protokół `CaseIterable`. Wystarczy go dodać do enumeracji i kompilator wygeneruje metodę statyczną (na typie), która zwraca tablicę z każdym case-em.
 */

enum QuoteWszywka: String, CaseIterable {
    case Niebo     = "Niebo w ziemi."
    case Badziewie = "Badziewie do badziewia."
    case Kur       = "Kur zapiał."
    case Kielich   = "A nie masz tam jakiego kielicha"

    init?(quoteIndex: Int) {
        if QuoteWszywka.allCases.indices.contains(quoteIndex) {
            self = QuoteWszywka.allCases[quoteIndex]
        } else {
            return nil
        }
    }

    func quote(_ author: Bool = false) {
        if author {
            print("\"\(rawValue)\" -- Wiesław Wszywka")
        } else {
            print("\"\(rawValue)\"")
        }
    }
}

QuoteWszywka(quoteIndex: 1)?.rawValue

let quoteWieslaw = QuoteWszywka.Kielich

run("🧈 quote Wiesław") {
    quoteWieslaw.quote()
    quoteWieslaw.quote(true)
}
//: ## Dowiązywanie Wartości / Associating Values
//: Enumeracje mogą posiadać swój własny typ (Int, String etc.) **lub** mogą mieć dowiązane do siebie instancje typów referencyjnych. 

class ClassA {
    let quote: String
    
    init(quote: String) {
        self.quote = quote
    }
}

class ClassB {}

enum CustomEnumeration {
    case unit           (ClassA)
    case productAB      (ClassA, ClassB)
    case namedProductAB (instanceA: ClassA, instanceB: ClassB)
}


let instanceOfCustomEnumeration: CustomEnumeration = .unit(ClassA(quote: "Można pić bez obawień"))

if case .unit(let instanceOfClassA) = instanceOfCustomEnumeration {
    instanceOfClassA.quote
}

//: Dokładnie taka "magia" dzieje się gdy korzystamy z Optionali.

var maybeQuote: Optional<String> // 💡 Przytrzymaj "ctrl" i naduś w "Optional"
type(of: maybeQuote)

maybeQuote = "Bedziesz to jesc?"
maybeQuote

maybeQuote = nil
maybeQuote

maybeQuote = .some("Bedziesz to jesc?")
maybeQuote

maybeQuote = .none
maybeQuote


//: ## [Rekurencyjne Enumeracje](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID536)
//: Aby zrozumieć rekurencje... 

enum Part { // indirect enum Czesc
    indirect case some(name: String, uid: Int, subpart: Part?) // indirect
}

func printParts(_ part: Part) -> String {

    if case let .some(name, uid, subpart) = part {

        var des = "Nazwa: \(name)\t UUID: \(uid)"

        if let subpart = subpart {
            des += " ]---> "
            des += printParts(subpart)
        }

        return des
    }

    return ""
}

let piston = Part.some(name: "Tlok", uid: 1234, subpart: .none)
let engine = Part.some(name: "V8", uid: 8, subpart: piston)
let auto   = Part.some(name: "Polonez", uid: 42, subpart: engine)

run("🍟 parts") {
    print(printParts(piston))
    print(printParts(engine))
    print(printParts(auto))
}

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
