//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
/*:
## Enumeration [dokumentacja](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html)
W Swift **enumeracje** to dużo bardziej uzyteczny i funkcjonalny typ niż w innych językach (C/ObjC). Dzięki nim możemy grupować powiązane ze sobą wartości (kierunki świata, zestawy kolorów, błędy HTTP etc.). Każda z tych wewnętrznych nazwanych wartości nosi nazwę "członek" (ang. member) 😎. Ponieważ **są typem** wartościowym to są przekazywane przez kopie.

Enumeracje **mają**:
* wyliczeniowe właściwowści na instancji
* "normalne" i wyliczeniowe właściwości na Typie Enumeracji
* initializery
* metody
* mogą wspierać subskrypty (notację z nawiasikiem [])
* adopotowac protokoły

Enumeracje **nie mają**:
* właściwości na instancji enumeracji
* dziedziczenia

*/

enum Kolor {
    case ladny
    case brzydki
    case bardzoBrzydki
}

let kolorLadny = Kolor.ladny
type(of: kolorLadny)

func jakiJestKolor(_ wejsciowy: Kolor) {
    "Kolor jest: \(wejsciowy)"
}

jakiJestKolor(kolorLadny)


//: Można zdefiniować enumeracje konkretnego typu. Możemy się też odwołać do wartości przechowywanej przed dany case korzystając z właściwości **rawValue**.



enum Wyliczanka: Int {
    case ene // 0
    case due = 5
    case rabe, chinczyk, polkna = 20, zabe // 6, 7, 20, 21
}

enum Zachmurzenie: String {
    case Burza      = "⛈"
    case GownoBurza = "💩⚡️"
    case Opady      = "🌧"
    case Brak       = "☀️"
}

let jakieZachmurzenie = Zachmurzenie.Burza
type(of: jakieZachmurzenie)
jakieZachmurzenie.rawValue

let coWypadlo = Wyliczanka.chinczyk
type(of: coWypadlo)
coWypadlo.rawValue

//: Możemy stworzyć instancje enumeracje korzystając z jej "surowej wartości" (jeżeli ją zanmy) ;)

var coWypadloSurowe = Wyliczanka(rawValue: 21) // 💡 rawValue: 42
type(of: coWypadloSurowe)
if let _ = coWypadloSurowe {
    coWypadloSurowe!
} else {
    coWypadloSurowe
}

var zachmurzenieSurowe = Zachmurzenie(rawValue: "💩⚡️")
type(of: zachmurzenieSurowe)
if let _ = zachmurzenieSurowe {
    zachmurzenieSurowe!
} else {
    zachmurzenieSurowe
}

//: "Casy" mogą być użyte jako klucze w słownikach.

let coUbrac: [Zachmurzenie: String] = [
    .Burza      : "Siedz w domu i bój się gromu!",
    .GownoBurza : "Kalosze, parasole i trzeźwiące sole!",
    .Opady      : "Na deszcz nie da rady!",
    .Brak       : "Leż na plaży i opalaj się na wznak!"
]

for (zach, co) in coUbrac {
    print("\(zach):\t\t\(co)")
}

print("")

//: ## Initializery Oraz Metody

enum CytatyWszywka: String {
    case Niebo     = "Niebo w ziemi."
    case Badziewie = "Badziewie do badziewia."
    case Kur       = "Kur zapiał."
    case Kielich   = "A nie masz tam jakiego kielicha"

    static let mozliweWartosci: [CytatyWszywka] = [CytatyWszywka.Niebo, Badziewie, .Kur, .Kielich]

    init?(ktory: Int) {
        if ktory < CytatyWszywka.mozliweWartosci.count {
            self = CytatyWszywka.mozliweWartosci[ktory]
        }
        else {
            return nil
        }
    }

    func cytuj(_ podajAutora: Bool = false) {
        if podajAutora {
            print("\"\(rawValue)\" -- Wiesław Wszywka")
        } else {
            print("\"\(rawValue)\"")
        }
    }
}

CytatyWszywka.init(ktory: 1)?.rawValue

let cytatWieslawa = CytatyWszywka.Kielich
cytatWieslawa.cytuj()
cytatWieslawa.cytuj(true)

print("")
//: ## Dowiązywanie Wartości / Associating Values
//: Enumeracje mogą posiadać swój własny typ (Int, String etc.) **lub** mogą mieć dowiązane do siebie instancje typów referencyjnych. 

class MojaKlasaA {
    let cytat: String
    
    init(cytat: String) {
        self.cytat = cytat
    }
}

class MojaKlasaB {}

enum MojaEnumeracja {
    case przypadekKlasyA   (MojaKlasaA)
    case przypadekKlasyA_B (MojaKlasaA, MojaKlasaB)
    case przypadekNazwany  (instancjaA: MojaKlasaA, instacjaB: MojaKlasaB)
}


let mojaEnumeracjaA: MojaEnumeracja = .przypadekKlasyA(MojaKlasaA.init(cytat: "Można pić bez obawień"))

if case .przypadekKlasyA(let instancjaA) = mojaEnumeracjaA {
    instancjaA.cytat
}

//: Dokładnie taka "magia" dzieje się gdy korzystamy z Optionali.

var bycMozeCytat: Optional<String> // 💡 Przytrzymaj "ctrl" i naduś w "Optional"
type(of: bycMozeCytat)

bycMozeCytat = "Bedziesz to jesc?"
bycMozeCytat

bycMozeCytat = nil
bycMozeCytat

bycMozeCytat = .some("Bedziesz to jesc?")
bycMozeCytat

bycMozeCytat = .none
bycMozeCytat


//: ## [Rekurencyjne Enumeracje](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID536)
//: Aby zrozumieć rekurencje... 

enum Czesc { // indirect enum Czesc
    case none
    indirect case some(nazwa: String, uid: Int, podczesc: Czesc?) // indirect

    static func wypiszCzesci(_ czesc: Czesc) -> String {

        if case let .some(nazwa, uid, czesc) = czesc {

            var des = "Nazwa: \(nazwa)\t UUID: \(uid)"


            if let czesc = czesc {
                des += " ]---> "
                des += Czesc.wypiszCzesci(czesc)
            }

            return des
        }

        return ""
    }
}

let tlok   = Czesc.some(nazwa: "Tlok", uid: 1234, podczesc: .none)
let silnik = Czesc.some(nazwa: "V8", uid: 8, podczesc: tlok)
let auto   = Czesc.some(nazwa: "Polonez", uid: 42, podczesc: silnik)

print(Czesc.wypiszCzesci(tlok))
print(Czesc.wypiszCzesci(silnik))
print(Czesc.wypiszCzesci(auto))

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
