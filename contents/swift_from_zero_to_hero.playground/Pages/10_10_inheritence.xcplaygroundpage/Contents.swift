//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Dziedziczenie](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Inheritance.html#//apple_ref/doc/uid/TP40014097-CH17-ID193)

import Foundation

/*:
Dziedziczenie jest najprostszym sposobem rozszerzania funkcjonalności klasy. Klasa dziedzicząca ma wszystkie zachowanie (metody) oraz właściwości co klasa bazowa (**superklasa**) i dodatkowo może dodać swoje lub nadpisać istniejące (w 99% jest to prawda ;)).
 
 Dziedziczenie pozwala też na ponowne użycie kodu już raz napisanego. Z jego pomocą można tworzyć całe hierarchie klas. Nie jest to rozwiązanie idealne, ale są pewne grupy problemów do których nadaje się idealnie.
 
 Poniżej jest przykład hierarchii klas. Każda klasa znajdująca się wyżej jest _superklasą_ klasy niżej. Patrząc na ten diagram można powiedzieć, że:
 
 * pies / kot jest ssakiem
 * pies / kot jest zwierzęciem
 * ssak / jest zwierzęciem
 
 Oznacza to, że `pies` i `kot` potrafi i ma te same właściwości co każdy `ssak`. Każdy `ssak` ma te same właściwości i metody co każde `zwierzę`. Z tego już naturalny wniosek, że `pies` i `kot` potrafi i ma te same właściwości co `zwierzę`.
 
 ```
           ┌──────────────────┐
           │      Animal      │
           └──────────────────┘
                     ▲
                     │
           ┌──────────────────┐
           │      Mammal      │
           └──────────────────┘
               ▲           ▲
          ┌────┘           └──────┐
┌──────────────────┐    ┌──────────────────┐
│       Dog        │    │       Cat        │
└──────────────────┘    └──────────────────┘
 ```
 
 W obiektowych językach programowania takie hierarchie występują praktycznie zawsze. Natomiast są dużo bardziej rozbudowane.
 
 ---
 
 Zaczniemy od napisania _klasy bazowej_. Ta klasa będzie _super klasą_ w dalszych przykładach.
*/

class Weather {
    var temperature: Int

    init(temperature: Int) {
        print("🛤", #function, "line:", #line)
        self.temperature = temperature
    }

    convenience init(randomString: String) {
        print("🛤", #function, "line:", #line)
        print("Calling custom init with string:", randomString)
        self.init(temperature: 42)
    }

    func weatherReport() -> String {
        print("🛤", #function, "line:", #line)
        return "Temperatura wynosi:  \(temperature)"
    }
}

/*:
 Jest zdefiniowana klasa `Weather`. Posiada jedno zmienne property `temperature` typu `Int`. Ma zdefiniowany `designated init` oraz jeden `convenience init` (akurat nic sensownego nie robi, ale posłuży nam do badania dziedziczenia). Klasa ma też zdefiniowane zachowanie, którym jest metoda `weatherReport`. Jest ona odpowiedzialna za generowanie raportu.
  
 # Klasy dziedziczą property oraz zachowania
 
 Utworzymy nową klasę, która będzie dziedziczyć po klasie `Weather`. Sama w sobie natomiast nie będzie niczego dodawać ani nadpisywać. W tym przykładzie chcę po prostu pokazać, że faktycznie właściwości i metody są dziedziczone.
 */

run("🥶 just inheritance") {

    class Detailed: Weather {}

    let detailedWeather = Detailed(randomString: "bez znaczenia")
    print(
        detailedWeather.weatherReport()
    )

    let detailedWeather2 = Detailed(temperature: 32)
    
    print(
        detailedWeather2.weatherReport()
    )
}

/*:
 Jak widać klasa `Detailed` odziedziczyła wszystko. W tym _kształcie_ jak jest teraz nie robi nic ciekawego. W pracy raczej ciężko jest spotkać taką klasę, która dziedziczy po innej a nic od siebie nie dodaje lub nie zmienia.
 
 Poniżej jest odrobinę bogatsza definicja klasy `Detailed`.

 */

run("🍁 inheritance with extra stuff") {

    class Detailed: Weather {
        var humidity = 69

        override init(temperature: Int) {
            print("🛤", #function, "line:", #line)
            super.init(temperature: temperature + 10) // wywołanie init w superklasie (Weather)
        }
        
//: 💡: Wszystkie convenience init mogą wołać init-y z tej samej klasy. Natomiast desygnowany init może wołać "w górę" (super.init) do superklasy (rzuć okiem na hierarchię wyżej dla przypomnienia).
        convenience init(humidity: Int) {
            // 💥 error: convenience initializer for 'Detailed' must delegate (with 'self.init')
            // 💥        rather than chaining to a superclass initializer (with 'super.init')
//            super.init(temperature: 0)
            
            print("🛤", #function, "line:", #line)
            self.init(temperature: 0) // wywołanie swojego nadpisanego init-a
            self.humidity = humidity
        }

        override func weatherReport() -> String {
            print("🛤", #function, "line:", #line)
            
            let reportFromSuper = super.weatherReport()
            let addedPart = "Wilgotność: \(humidity)"

            return reportFromSuper + "\t\t" + addedPart
        }
    } // class

    let weather = Detailed(humidity: 69)
    
    print(
        weather.temperature,
        weather.humidity,
        "\n",
        weather.weatherReport()
    )
}

/*:
 Wydarzyło się tu kilka ciekawych rzeczy. Doszło nowe property opisujące wilgotność. Nadpisany init i dodany kolejny. Ostatecznie nadpisana implementacja metody generującej raport pogody.
 
 # super
 
 Przy pomocy słowa kluczowego `override` powiedzieliśmy kompilatorowi, że "nadpisujemy" implementację init-a (w sumie czegokolwiek). Wewnątrz tej implementacji używamy słowa kluczowego `super`. Mówi ono kompilatorowi, że ma wywołać implementacje z super klasy.
 
 Możliwe, że znacznie lepiej jest to widoczne przy nadpisaniu metody `weatherReport`.
 
 */

//: ### Nadpisywanie Własciwości

run {
    class Detailed: Weather {

        override var temperature: Int {
            get {
                super.temperature
            }
            set {
                super.temperature = newValue
            }
        }

        init() { super.init(temperature: 42) }
    }

    let weather = Detailed()
    weather.temperature
}

/*:
 ### Wymuszenie Posiadania Init
 
 Tworząc klasę bazową można wymusić na klasach dziedziczących posiadanie konkretnego init-a. Służy do tego słowo kluczowe `required`.
 */

run {
    class Anchor {
        var name: String
        init () { name = "Yanet Garcia" }
        
        required init(name: String) { self.name = name }
    }

    class HotAnchor: Anchor {
        init(howHot: Int) {
            super.init()
        }
        
// error: 'required' modifier must be present on all overrides of a required initializer
        required init(name: String) {
            super.init(name: name)
        }
    }
}

/*:
 Jeżeli klasa dziedzicząca nie definiuje swoich init-ów to automatycznie dziedziczy wszystkie z super klasy. Natomiast jeżeli posiada definicje _swoich_ to musi dostarczyć definicję tych init-ów, które są oznaczone jako wymagane.
 
 Brzmi dziwnie? Trochę jest, ale najważniejsze jest to, że kompilator patrzy na ręce. Gdy coś będzie nie tak to rzuci odpowiednim błędem, który można łatwo wygooglać ;)

 ## Zapobieganie Dziedziczeniu

 Czasami chcemy wymusić aby jakaś właściwość lub metoda nie zostały nadpisane w podklasie. Używa się do tego słowa kluczowego **final**. Dodatkowym bonusem jest to, że kompilator na tej podstawie jest w stanie wykonać optymalizację generowanego kodu (bezpośredni skok do pamięci bez przechodzenia przez __vtable__).
 */


run {
    class Anchor {
        final var name: String = "Yanet Garcia"

        final func presentWeather() {
            "Nadchodzi ⛈"
        }
    }

    class BeginnerTVStar: Anchor {
        // 💥 error: Property overrides a 'final' property
//        override var name: String {
//            get { "Janusz" }
//            set { super.name = "Janusz"}
//        }

//         💥 error: Instance method overrides a 'final' instance method
//        override func presentWeather() {}
    }
}

/*:
 # Polimorfizm
 
 Po co te wszystkie klasy? I po co te całe dziedziczenie? Zobaczmy na przykładzie z początku tego placu zabaw.
 */

class Animal {
    func animalBehaviour() { print(#function, #line) }
}

class Mammal: Animal {
    override func animalBehaviour() { print(#function, #line, "🍼") }
}

class Dog: Mammal {
    override func animalBehaviour() { print(#function, #line, "🐶") }
}

class Cat: Mammal {
    override func animalBehaviour() { print(#function, #line, "🐱") }
}

let animal = Animal()
let mammal = Mammal()
let dog = Dog()
let cat = Cat()

/*:
 Ponieważ każdą z tych instancji możemy potraktować jako zwierzę to możemy napisać funkcję, która wie o świecie tylko tyle, że są zwierzęta.
 */

run("🦋") {
    func doAnimalStuff(_ animal: Animal) {
        animal.animalBehaviour()
    }
    
    doAnimalStuff(animal)
    doAnimalStuff(mammal)
    doAnimalStuff(dog)
    doAnimalStuff(cat)
}

/*:
 
 Każda z instancji uruchomiła swoją implementacje a nie z klasy bazowej (super klasy). Istnieje jeden wspólny interface (API) dla instancji różnych typów. Jeżeli po pewnym czasie dojdzie jeszcze kolejna klasa, która dziedziczy z tej to ten kod nie będzie musiał się zmienić. 
 
 Temat jest znacznie szerszy i bardziej skomplikowany. Istnieje kilka rodzajów polimorfizmu, zahacza jeszcze o coś takiego jak `covariance` i `contravariance` (chyba się to tłumaczy na PL jako kowariancja i kontrawariancja). Nie jest to coś o czym trzeba wiedzieć dziś, po prostu warto wiedzieć, że jest coś jeszcze. Oraz to, że jest kilka rodzajów polimorfizmu.
 
 */



print("🦄")


//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
