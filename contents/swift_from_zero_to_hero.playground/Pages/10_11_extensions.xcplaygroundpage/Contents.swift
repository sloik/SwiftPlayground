//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Rozszerzenia / Kategorie](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html)

import Foundation

/*:
Swift (jak również Objective C) daje nam jeszcze jeden mechanizm __rozszerzania__ funkcjonalnosci danego typu. **Rozszerzenia** (objc: kategorie) pozwalają dodać funkcjonalność do już istniejącego typu (sklasa, struktura a nawet protokół) i to nawet gdy nie mamy dostępu do kodu źródłowego 😎.

Możemy:
* dodawać wyliczeniowe właściwości
* definiować metody instancyjne jak również na typie
* definiować typy zagnieżdżone
* implementować (adoptować?) na danym typie protokół
* w przeciwieństwie do Objective C rozszerzenia **nie** posiadają nazwy

Używamy słowa kluczowego **extension** nastepnie typ, który rozszerzamy i opcjonalnie po ":" protokoły, które chcemy zaimplementować.
*/
extension String {
    var licznikZnakow: Int {
        return characters.count // 💡: można też dodać odwołanie do 'self'
    }
}

let cytat = "Można pić bez obawien"
cytat.licznikZnakow

//: Standardowa biblioteka Swifta używa rozszerzeń do grupowania kodu. Wystarczy rzucić okiem na definicje String by zobaczyć z jak wielu różnych rozszerzeń się składa.

enum Pogoda {
    case goraco (temperatura: Int)
    case mokro  (opday: String)
}

let pogodaJakaJest: Pogoda = .goraco(temperatura: 42)

//pogodaJakaJest.jakJestGoraco() // 💥 teoria mówi, że tu też powinno działać, ale nie działa :(

extension Pogoda {
    func jakJestGoraco() -> String {
        switch self {
        case .goraco (let temp):

            switch temp {
            case 0..<15: return "⛄️"
            case 15..<40: return "☀️"
            case 40..<(Int.max-1): return "🔥"

            default: return "❄️"
            }


        default:
            return "Skąd mam wiedziec!"
        }
    }
}

pogodaJakaJest.jakJestGoraco()

/*:
## Implementacja protokołu
Rozszerzenie świetnie nadaje się do wydzielenia grupy medod, które są wymagane przez prrotokół.
*/

extension Pogoda: CustomStringConvertible {
    var description: String {
        switch self {
        case .goraco(let temperatura):
            return "Opisuje Temerature: \(temperatura)"
        case .mokro(let opday):
            return "Opisuje Opday: \(opday)"
        }
    }
}

pogodaJakaJest.description

//: ## Rozszerzanie Protokołów

protocol Wdziek {
    var urokOsobisty: Int {set get}
}

extension Wdziek {
    var urokOsobisty: Int {
        get {
            return 8
        }

        set {} // jeżeli teg nie damy to każdy typ musiałby zaimplementować getter i setter
    }
}

protocol Farbowalna {
    var kolorWlosow: String { get }
    func opiszWlosy()
}

extension Farbowalna {
    var kolorWlosow: String { return "💁" }

    func opiszWlosy() {
        print("Farbowalna ma teraz wlosy: \(kolorWlosow)")
    }
}

do {
    class SuperPogodynka: Wdziek, Farbowalna { }

    let pogodynka = SuperPogodynka()
    pogodynka.urokOsobisty
    pogodynka.kolorWlosow
    pogodynka.opiszWlosy()
}

//: Nadpisywanie Domyslnej Implementacji

do {

    class SuperPogodynka: Wdziek, Farbowalna {
        var urokOsobisty: Int

        init(urok: Int) {
            urokOsobisty = urok
        }
    }

    let pogodynka = SuperPogodynka(urok: 10)
    pogodynka.urokOsobisty
}


//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
