//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Rozszerzenia / Kategorie](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html)

import Foundation

/*:
Swift (jak również Objective C) daje nam jeszcze jeden mechanizm __rozszerzania__ funkcjonalnosci danego typu. **Rozszerzenia** (objc: kategorie) pozwalają dodać funkcjonalność do już istniejącego typu (klasa, struktura a nawet protokół) i to nawet gdy nie mamy dostępu do kodu źródłowego 😎.

Możemy:
* dodawać wyliczeniowe właściwości
* definiować metody instancyjne jak również na typie
* definiować typy zagnieżdżone
* implementować (adoptować?) na danym typie protokół
* w przeciwieństwie do Objective C rozszerzenia **nie** posiadają nazwy

Używamy słowa kluczowego **extension** nastepnie typ, który rozszerzamy i opcjonalnie po ":" protokoły, które chcemy zaimplementować.
*/
extension String {
    var characterCounter: Int {
        count
    }
}

run("🪕 string extension") {
    let quote = "Można pić bez obawień"
    
    print("Cytat ma", quote.characterCounter, "znaków.")
}

/*:
 Standardowa biblioteka Swifta używa rozszerzeń do grupowania kodu. Wystarczy rzucić okiem na definicje String by zobaczyć z jak wielu różnych rozszerzeń się składa.
 
 Rozszerzenia pozwalają dodawać ze sobą zgrupowaną funkcjonalność. Pozwala to na umieszczanie blisko siebie metod i property, które robią podobne rzeczy. Mała rzecz a może sprawić, że kod będzie bardziej czytelny.
 */

enum Weather {
    case hot(temp: Int)
    case wet(rain: String)
}

extension Weather {
    func howHotIsIt() -> String {
        switch self {
        case .hot(let temp):
            switch temp {
            case 0..<15          : return "⛄️"
            case 15..<40         : return "☀️"
            case 40..<(Int.max-1): return "🔥"
            default              : return "❄️"
            }

        default: return "Skąd mam wiedzieć!"
        }
    }
}

/*:
 Teraz można zobaczyć w akcji nowo dodaną metodę!
 */
run("🎈weather extension") {
    let anyWeather: Weather = .hot(temp: 42)

    print(
        anyWeather.howHotIsIt()
    )
}

/*:
## Implementacja protokołu
 
Rozszerzenie świetnie nadaje się do wydzielenia grupy metod, które są wymagane przez protokół. Często chcemy daną instancję przedstawić jako String. Możemy zatem zakonformować do protokołu `CustomStringConvertible`. Możemy też użyć do tego rozszerzenia!
*/

extension Weather: CustomStringConvertible {
    var description: String {
        switch self {
        case .hot(let temperature) : return "Opisuje Temperaturę: \(temperature)"
        case .wet(let amountOfRain): return "Opisuje Opady: \(amountOfRain)"
        }
    }
}

run("⛺️ protocol conformance"){
    let anyWeather: Weather = .hot(temp: 42)
    
    print(
        anyWeather.description
    )
}

/*:
 # Rozszerzanie Protokołów
 
 Rozszerzenia mogą posłużyć do definiowania domyślnej implementacji dla protokołu. Zaczniemy od zdefiniowania protokołu, który posłuży do opisania _uroku osobistego_.
 */

protocol Charm {
    var personal: Int {set get}
}

/*:
 Prosty protokół dodający jedno property. Jeżeli uznamy, że dobrą wartością początkową jest 8 to możemy napisać rozszerzenie dzięki któremu typy konformujące nie będą musiały mieć tego zdefiniowanego a będą miały to dostępne.
 */

extension Charm {
    var personal: Int {
        get { 8 }
        set {   } // jeżeli tego nie damy to każdy typ musiałby zaimplementować getter i setter
    }
}

/*:
 
 Rozszerzenia do protokołów to zwykłe rozszerzenia. Jeżeli jest potrzeba dodania dodatkowych metod, które nie są wymagane przez protokół to można to zrobić. Typy konformujące zyskują dużo bardziej czytelne API i wygodniejsze.
 
 */

protocol Dyable {
    var hairColor: String { get }
}

extension Dyable {
    var hairColor: String { "💁" }

    func describeHair() {
        print("Farbowalna ma teraz wlosy: \(hairColor)")
    }
}

/*:
 Potrzebujemy czegoś na czym można przetestować te wspaniałe cuda. Pusta klasa tylko deklarująca, że konformuje do tych protokołów nada się świetnie.
 */
run("🧗‍♀️ default impl") {
    final class SuperWeatherAnchor : Charm, Dyable { }

    let anchor = SuperWeatherAnchor()
    anchor.personal
    anchor.hairColor
    anchor.describeHair()
}

/*:
 `SuperWeatherAnchor` ma czystą definicje. Cała funkcjonalność pochodzi z domyślnych implementacji zdefiniowanych w rozszerzeniach. Warto aby nie uciekła jedna rzecz. Metoda `describeHair` nie jest zdefiniowana w protokole. Jednak rozszerzenie protokołu to zwykłe rozszerzenie. Można dodać tez inne metody. Dobrze jest aby jakoś ułatwiały pracę z instancjami danego typu a nie były _od czapy_.
 
 ## Nadpisywanie Domyślnej Implementacji
 
 Gdy domyślna implementacja jakiegoś protokołu nie jest tym czego trzeba to po prostu piszemy to _normalnie_ tak jakbyśmy konformowali do protokołu.
 */


run("🥈 some defined some not") {

    final class SuperWeatherAnchor: Charm, Dyable {
        var personal: Int

        init(charm: Int) { personal = charm }
    }

    let anchor = SuperWeatherAnchor(charm: 10)
    anchor.personal
    anchor.hairColor
    anchor.describeHair()
}

/*:
 # Tyle
 
 W gruncie rzeczy to tyle. Rozszerzenia w Swift to bardzo fajny i użyteczny ficzer. Ważne, żeby zapamiętać że:
 
 * można dodać funkcjonalności do typów, których nie jesteśmy właścicielami (frameworki _trzeciej imprezy_)
 * używać do definiowania domyślnych implementacji protokołów
 * organizować kod aby był czytelniejszy
 
 */

print("🍑")


//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
