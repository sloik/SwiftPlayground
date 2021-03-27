//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Dziedziczenie](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Inheritance.html#//apple_ref/doc/uid/TP40014097-CH17-ID193)

import Foundation

/*:
Dziedziczenie jest najprostrzym sposobem rozszerzania funkcjonalności klasy. Klasa dziedzicząca ma wszystkie zachowanie (metody) oraz właściwości co klasa bazowa (**superklasa**) i dodatkowo może dodać swoje lub nadpisać istniejące (w 99% jest to prawda ;)).
*/

class Weather {
    var temperature: Int

    init(temperature: Int) {
        self.temperature = temperature
    }

    convenience init(randomString: String) {
        self.init(temperature: 42)
    }

    func weatherReport() -> String {
        return "Temperatura wynosi:  \(temperature)"
    }
}

run("🥶 just inheritance") {

    class Detailed: Weather {}

//: Klasa odziedziczyła wszystkie właściwości jak również domyslny initializer.
    let detailedWeather = Detailed(randomString: "bez znaczenia")
    print(
        detailedWeather.weatherReport()
    )

    let detailedWeather2 = Detailed(temperature: 32)
    
    print(
        detailedWeather2.weatherReport()
    )
}

run("🍁 inheritance with extra stuff") {

    class Detailed: Weather {
        var humidity = 69

        override init(temperature: Int) {
            super.init(temperature: temperature) // wywolanie init w superklasie (Pogoda)
        }
        
//: 💡: Wszystkie convenience initializery mogą wołać init-y z tej samej klasy. Natomiast desygnowany init może wołać "w górę" do superklasy.
        convenience init(humidity: Int) {
//            super.init(temperatura: 0) // 💥
            self.init(temperature: 0) // wywolanie swojego nadpisanego
            self.humidity = humidity
        }

//: ### Nadpisywanie Metod

        override func weatherReport() -> String {
            let reportFromSuper = super.weatherReport()
            let addedPart = "Wilgotność: \(humidity)"

            return reportFromSuper + "\t\t" + addedPart
        }
    } // class

    let weather = Detailed(humidity: 69)
    weather.weatherReport()
}

//: ### Nadpisywanie Własciwości

run("🌼 override property") {
    class Detailed: Weather {

//: error: cannot override with a stored property 'temperatura' -> nadpisane właściwości muszą być __computed__
        override var temperature: Int {
            get {
                return super.temperature
            }
            set {
//                fatalError("\(__FUNCTION__) 💥") // 💡: tak można wymusić nie ustawianie zmiennej ;)
//                super.temperatura = newValue
            }
        }

        init() { super.init(temperature: 42) }
    }

    let weather = Detailed()
    weather.temperature
}

//: ### Wymuszenie Posiadania Metody

run("👩🏼‍💼") {

    class Anchor {
        var name: String
        init () { name = "Yanet Garcia" }
        required init(name: String) { self.name = name }
    }

    class HotAnchor: Anchor {

        override init() { super.init() }

//: Bez < error: 'required' initializer 'init(imie:)' must be provided by subclass of 'Pogodynka' >
        required init(name: String) {
            super.init(name: name)
        }
    }
}

//: ## Zapobieganie Dziedziczeniu

run("👘") {

//: Czasami chcemy wymusić aby jakaś właściwośc lub metoda nie zostały nadpisane w podklasie. Używa się do tego słowa kluczowego **final**. Dodatkowym bonusem jest to, że kompilator na tej podstawie jest w stanie wykonać optymalizację generowanego kodu (bezpośredni skok do pamieci bez przechodzenia przez __vtable__).

    class Anchor {
        final var name: String = "Yanet Garcia"

        final func przedstawPogode() {
            "Nadchodzi ⛈"
        }
    }

    class BeginierTVStar: Anchor {
        // 💥 error: var overrides a 'final' var override var imie...
//        override var imie: String { get { "Janusz" } set { super.imie = "Janusz"} }

        // 💥 error: instance method overrides a 'final' instance method...
//        override func przedstawPogode() {}
    }
}


print("🦄")


//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
