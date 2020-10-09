//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Class

import Foundation

protocol Weatherable {}

var delay: UInt32 = 5
//: Klasę definiujemy przy pomocy użycia słowa kluczowego __class__ następnie nadajemy nazwę i {} w których znajduje się kod klasy.
class MyClass {

}

/*:
 Klasa dziedzicząca po _MojaKlasa_ i implementująca protokół _Pogodynka_ . Aby określić, że klasa dziedziczy po innej klasie należy po jej nazwie umieścić " __:__ " a następnie podać nazwę klasy po której dziedziczy (_SuperKlasy_). Dalej po przecinku można wymienić protokoły jakie implementuje klasa.
 
 W Swift klasy mogą dziedziczyć tylko po jednej klasie. Mogą natomiast implementować do wielu protokołów.
 */
class MySubclass: MyClass, Weatherable {

}


class Weather: MyClass {

//: ### Właściwości Instancji
    var temperature: Int?     // nie musi mieć wartości
    var humidity = 78         // przypisana domyślna wartość
    let maxTemperature:Int    // musi mieć wartość ale zostanie nadana w init
    var city: String?

//: ### Właściwości Klasy
    static fileprivate(set) var numberOfWeatherStations = 0

//: ### [Obserwatory Właściwości](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-ID262) (nie KVO!).
    var overcast: String {

        // Wywołane przed ustawieniem wartości.
        willSet {
            print("Nowa pogoda będzie: \(newValue)")
        }

        // Wywołane po ustawieniu wartości.        
        didSet(oldOvercast) {
            print("Stara pogoda była: \(oldOvercast)")
        }
    }

//: ### Settery i Gettery
    var tempWithOvercast: (temp: Int?, zach: String) {
        get {
            return (temperature, overcast)
        }

//: Mamy dostęp do przypisywanej pod stałą o nazwie **newValue**. Możemy też ją sami nazwać podająć jej nazwę w nawiasach za słowem kluczowym **set**.
        set { // 💡: set(nowaTemperaturaOrazNoweZachmurzenie) {
            type(of: newValue)
            temperature  = newValue.temp
            overcast = newValue.1
        }
    }

//: Jeżeli mamy tylko getter to można pominąć słowo kluczowe get.

    var tempFarneheight : Double? {
        if let temperature = temperature {
            return Double(temperature) * 1.8 + Double(32)
        }
        else {
            return nil
        }
    }

//: ### ["Lenive" właściwości.](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-ID257)
//: W życiu czasem tak się przytrafia, że pewne zasoby są dostępne dopiero po tym jak w pełni będziemy pełnoletni. Może też się tak wydarzyć, że nie chcemy płacić kosztu związanego z tworzeniem lub rozpoczynaniem jakiegoś procesu gdy jest on rzadko używany. Korzystając z oznaczenia _właściwości_ jako _leniwej_ (**lazy**) możemy opóźnić wykonanie kodu inicjalizującego do momentu aż ktoś faktycznie z tego nie skorzysta. Blok, który jest użyty do inicjalizacji będzie wywołany tylko raz. Możemy też przypisać takiej zmiennej wartość później (w przeciwieństwie do _wyliczonych właściwości_ ).

    lazy var tempLast30Days: [Int] = {
        var temp: [Int] = []

        print("🍴 Leniwe raz!")
        
        sleep(delay)
        
        for _ in 0..<30 {
            temp += [Int(arc4random_uniform(30))]
        }
        print("😱 Matko jak długo!")

        return temp
    }()

//: ## Nil Resetable

    lazy var weatherHost: String!  = {
        return "Mariana"
    }()

//: ### [inicjalizacja](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html)
//: W Swift każda klasa musi posiadać __desygnowany initilizer__ jeżeli wszystkie nie opcjonalne właściwości/properties nie mają domyślnie przypisanej wartości. Jeżeli natomiast mają to jest automatycznie generowany pusty initilizer.

    init(maxTemperature: Int, currentOvercast: String) { // brak 'func'
        self.maxTemperature = maxTemperature
        overcast  = currentOvercast           // można pominąć 'self'

        Weather.numberOfWeatherStations += 1
        print(#function + "\tliczbaInstancji: \(Weather.numberOfWeatherStations)")
        // 💡 brak zwrwacanej wartosci
    }

//: Pomocnicze initilizery muszą być oznaczone słowem kluczowym __convenience__. Mogą wołać inne pomocnicze "inity" ale nie mogą wołać "initów" z superklasy.
    convenience init(maxTemperature: Int) {
        self.init(maxTemperature: maxTemperature, currentOvercast: "🌧")
//        super.init() // 💥
    }

//: Zanim kompilator zezwoli na odwolanie się do _self_ to instancja musi być w pełni zainicjalizowana. To znaczy wszystkie nie opcjonalne właściwości muszą mieć przypisaną wartość.
    convenience init(maxTemperature: Int, temperature: Int) {
//        self.temperature = temperature // 💥

        self.init(maxTemperature: maxTemperature)

        self.temperature = temperature // 👍🏻
    }

//: Nie zawsze inicjalizacja obiektu może się udać. Zabraknie pamięciu lub dane wprowadzone do "init"-a nie mają sensu. W takiej sytuacji chcemy pokazać, że jednak coś się nie udało. Służą do tego _fejlujące initializery_ ([dokumentacja](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID224)). Deklaruje je sie dodając **?** za **init**. Dość ciekawym kuriozum jest sytuacja w której jesteśmy pewni, że fejlujący init nigdy nie zfejluje. Wtedy możemy "?" zastąpić **!** i nie otrzymamy wtedy Optional-a.

    convenience init?(city: String?, temperature: Int) { // 💡: init!(...
        self.init(maxTemperature: 1000)

        city.map {
            self.city = $0
        }
        guard let city = city , city.count > 0 else {
            return nil // Jedyny moment kiedy możemy zwrócić coś w "inicie"
        }

        self.city = city
    }

/*:
    Tworzenie obiektów (instancji klas) to tylko połowa historii. Drugą połową jest deinicjalizacja. W bloku `deinit` definiuje się akcje, które mają się wykonać w momencie gdy do instancji nie ma już więcej żadnych _silnych referencji_.
     
     Powolutku zmierzamy nieuchronnie w tematy związane z zarządzaniem pamięcią. Nie ma się czego bać a sam `deinit` to _wygodne_ miejsce aby oddać wszelkie zasoby, które zostały przydzielone.
 */

    deinit {
        Weather.numberOfWeatherStations -= 1
        print(#function + "\t", "liczbaInstancji: \(Weather.numberOfWeatherStations)")
    }

//: ### Metody Instancji
    func weatherReport() -> String {
        var raport = ""

        if let city = city {
            raport += "Pogoda dla miasta: \(city.uppercased())\n"
        }

        if let temperature = temperature {
            raport += "\t Temperatura: \(temperature)\n"
        }

        raport += "\tZachmurzenie: \(overcast)\n"
        raport += "\t  Wilgotnosc: \(humidity)\n"

        print(raport)

        return raport
    }

//: Metody Klasowe / Metody Typu
    static func newWeather(_ city: String, temperature: Int, maxTemperature: Int, humidity: Int, currentOvercast: String ) -> Weather {

        let pogoda = Weather(maxTemperature: maxTemperature, currentOvercast: currentOvercast)
        pogoda.humidity = humidity
        pogoda.temperature = temperature
        pogoda.city = city

        return pogoda
    }

} // class Weather: MyClass

//: Inaczej jak przy zwykłych funkcjach pierwszy podany argument jest widoczny przy wywołaniu. Jeżeli chcemy aby nie był widoczny w inicie możemy użyć "_" aby sie go pozbyć.
let weatherInstance = Weather(maxTemperature: 10000)
weatherInstance.temperature = 12

let weatherInCity = Weather(city: "Białystok", temperature: 42) // 💡: !
type(of: weatherInCity)
weatherInCity

weatherInCity?.temperature = 24
weatherInCity?.temperature

weatherInstance.tempWithOvercast = (18, "🌥")
weatherInstance.tempWithOvercast
weatherInstance.tempFarneheight // google: 18 degrees Celsius = 64.4 degrees Fahrenheit

//: ## Test Leniwych

//instancjaPogody.temperaturaOstatni30Dni = [5,10,15] // 💡: zobacz co się stanie pod odkomentowaniu

for temp in weatherInstance.tempLast30Days {
    temp
}

//: Co się stanie jak zawołam jeszcze raz?
for temp in weatherInstance.tempLast30Days {
    temp
}

weatherInstance.tempLast30Days = [5,10,15]
//: Co się stanie jak zawołam jeszcze raz?
for temp in weatherInstance.tempLast30Days {
    temp
}

weatherInstance.weatherReport()

do {
    let zFabrykiPogody = Weather.newWeather("Zakopane", temperature: 16, maxTemperature: 100, humidity: 66, currentOvercast: "☀️")
    zFabrykiPogody.weatherReport()
}

//: Nil Resetable

weatherInstance.weatherHost
weatherInstance.weatherHost = nil
weatherInstance.weatherHost = "Marta"
weatherInstance.weatherHost
weatherInstance.weatherHost = nil
weatherInstance.weatherHost

print("")
//: ## Klasy Zagnieżdżone
//: Klasy mozemy definiować wewnątrz innej klasy.
delay

class OuterClass {

    class InnerClass {
        init () { print("Wewnetrzna -> 😋 init")}
        deinit { print("Wewnetrzna -> 😵 deinit") }

        func innerMethod() {
            print("Wewnetrzna -> 👑 metodaW")
        }
    }

    var inner = InnerClass()

    init () { print("Zewnetrzna -> 😋 init")}
    deinit { print("Zewnetrzna -> 😵 deinit") }

    func justOuterMethod() {
        print("Zewnetrzna -> 💍 metodaZ")
    }

    func outherMethodCallingOnInnerInstance() {
        inner.innerMethod()
    }
}


do {
    let outerInstance = OuterClass()
    type(of: outerInstance)
    outerInstance.justOuterMethod()

//: 💡 Type klasy wewnetrznej jest związany z typem klasy zewnetrznej
    type(of: outerInstance.inner)

    outerInstance.outherMethodCallingOnInnerInstance()
    outerInstance.inner.innerMethod()
}
print("")

do {
    print("Tworze instancje klasy wewnetrznej:".uppercased())
    let innerInstance = OuterClass.InnerClass()
    type(of: innerInstance)
}

/*:
 A co jeżeli klasa wewnątrz będzie prywatna?
 
 > O modyfikatorach dostępu opowiemy trochę później w serii. Na ten moment powiedzmy, że pozwalają pokazać ukryć detale implementacyjne a udostępnić publiczny interface.
 */

print("\nWewnetrzna Klasa Prywatna".uppercased())
class OtherOuter {

    fileprivate class InnerClass {
        init () { print("Wewnetrzna -> 😋 init")}
        deinit { print("Wewnetrzna -> 😵 deinit") }

        func innerMethod() {
            print("Wewnetrzna -> 👑 metodaW")
        }
    }

    fileprivate var inner = InnerClass()

//    var returner: OtherOuter.InnerClass { // 💥
//        inner
//    }

    init () { print("Zew -> 😋 init")}
    deinit { print("Zew -> 😵 deinit") }

    func justOtherOuterMethod() {
        print("Zew -> 💍 metodaZ")
    }

    func outherMethodCallingOnInnerInstance() {
        inner.innerMethod()
    }
}

do {
    let z = OtherOuter()
    type(of: z)
    z.justOtherOuterMethod()
    z.outherMethodCallingOnInnerInstance()
}

print("\n")
//: ## Oczywiście Szaleństwu Nie Ma Konca 😱

class I {
    class N {
        class C {
            class E {
                class P {
                    class C {
                        class J {
                            class A {
                                init() {print("A")}
                            }

                            var a = A()
                            init() {print("J")}
                        }

                        var j = J()
                        init() {print("C")}
                    }

                    var c = C()
                    init() {print("P")}
                }

                var p = P()
                init() {print("E")}
            }

            var e = E()
            init() {print("C")}
        }

        var c = C()
        init() {print("N")}
    }

    var n = N()
    init() {print("I")}
}

print("Najbardziej wewnetrzny".uppercased())

let sen = I.N.C.E.P.C.J.A()
type(of: sen)

print("\nNajbardziej zewnetrzny".uppercased())

let i = I()
type(of: i)
type(of: i.n.c.e.p.c.j.a)

print("\nGdzieś ze środka".uppercased())
let e = I.N.C.E()
type(of: e)

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
