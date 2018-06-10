//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Dziedziczenie](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Inheritance.html#//apple_ref/doc/uid/TP40014097-CH17-ID193)

import Foundation

/*:
Dziedziczenie jest najprostrzym sposobem rozszerzania funkcjonalności klasy. Klasa dziedzicząca ma wszystkie zachowanie (metody) oraz właściwości co klasa bazowa (**superklasa**) i dodatkowo może dodać swoje lub nadpisać istniejące (w 99% jest to prawda ;)).
*/

class Pogoda {
    var temperatura: Int

    init(temperatura: Int) {
        self.temperatura = temperatura
    }

    convenience init(jakiesCos: String) {
        self.init(temperatura: 42)
    }

    func zaraportujPogode() -> String {
        return "Temperatura wynosi:  \(temperatura)"
    }
}

xrun {

    class DokladniejszaPogoda: Pogoda {}

//: Klasa odziedziczyła wszystkie właściwości jak również domyslny initializer.
    let pogoda = DokladniejszaPogoda.init(jakiesCos: "bez znaczenia")
    pogoda.zaraportujPogode()

    let pogoda2 = DokladniejszaPogoda.init(temperatura: 32)
    pogoda2.zaraportujPogode()
}

xrun {

    class DokladniejszaPogoda: Pogoda {
        var wilgotnosc = 69

        override init(temperatura: Int) {
            super.init(temperatura: temperatura) // wywolanie init w superklasie (Pogoda)
        }
        
//: 💡: Wszystkie convenience initializery mogą wołać init-y z tej samej klasy. Natomiast desygnowany init może wołać "w górę" do superklasy.
        convenience init(wilgotnosc: Int) {
//            super.init(temperatura: 0) // 💥
            self.init(temperatura: 0) // wywolanie swojego nadpisanego
            self.wilgotnosc = wilgotnosc
        }

//: ### Nadpisywanie Metod

        override func zaraportujPogode() -> String {
            let oryginalna = super.zaraportujPogode()
            let wlasna = "Wilgotność: \(wilgotnosc)"

            return oryginalna + "\t\t" + wlasna
        }
    } // class

    let pogoda = DokladniejszaPogoda.init(wilgotnosc: 69)
    pogoda.zaraportujPogode()
}

//: ### Nadpisywanie Własciwości

xrun {
    class DokladniejszaPogoda: Pogoda {

//: error: cannot override with a stored property 'temperatura' -> nadpisane właściwości muszą być __computed__
        override var temperatura: Int {
            get {
                return super.temperatura
            }
            set {
//                fatalError("\(__FUNCTION__) 💥") // 💡: tak można wymusić nie ustawianie zmiennej ;)
//                super.temperatura = newValue
            }
        }

        init() { super.init(temperatura: 42) }
    }

    let pogoda = DokladniejszaPogoda.init()
    pogoda.temperatura 
}

//: ### Wymuszenie Posiadania Metody

xrun {

    class Pogodynka {
        var imie: String
        init () { imie = "Sandra" }
        required init(imie: String) { self.imie = imie }
    }

    class SexyPogodynka: Pogodynka {

        override init() { super.init() }

//: Bez < error: 'required' initializer 'init(imie:)' must be provided by subclass of 'Pogodynka' >
        required init(imie: String) {
            super.init(imie: imie)
        }
    }
}

//: ## Zapobieganie Dziedziczeniu

xrun {

//: Czasami chcemy wymusić aby jakaś właściwośc lub metoda nie zostały nadpisane w podklasie. Używa się do tego słowa kluczowego **final**. Dodatkowym bonusem jest to, że kompilator na tej podstawie jest w stanie wykonać optymalizację generowanego kodu (bezpośredni skok do pamieci bez przechodzenia przez __vtable__).

    class Pogodynka {
        final var imie: String = "Sandra"

        final func przedstawPogode() {
            "Nadchodzi ⛈"
        }
    }

    class PoczatkującaPogodynka: Pogodynka {
        // 💥 error: var overrides a 'final' var override var imie...
//        override var imie: String { get { "Janusz" } set { super.imie = "Janusz"} }

        // 💥 error: instance method overrides a 'final' instance method...
//        override func przedstawPogode() {}
    }
}

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
