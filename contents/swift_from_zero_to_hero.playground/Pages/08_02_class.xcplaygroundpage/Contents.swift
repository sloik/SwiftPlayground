//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Class

import Foundation

protocol Pogodynka {}

var opoznienie: UInt32 = 5
//: Klasę definiujemy przy pomocy uzycia słowa kluczowego __class__ następnie nadajemy nazwę i {} w których znajduje się kod klasy.
class MojaKlasa {

}

//: Klasa dziedzicząca po _MojaKlasa_ i implementujaca protokół _Pogodynka_ . Aby określić, że klasa dziedziczy po innej klasie należy po jej nazwie umieścić " __:__ " a następnie podać nazwę klasy po której dziecziny (_SuperKlasy_). Dalej po przecinku moża wymienić protokoły jakie implementuje klasa.
class MojaPodklasa: MojaKlasa, Pogodynka {

}


class Pogoda: MojaKlasa {

//: ### Właściwości Instancji
    var temperatura: Int?       // nie musi mieć wartości
    var wilgotnosc = 78         // przypisana domyśna wartość
    let maxTemperatura:Int      // musi mieć wartość ale zostanie nadana w init
    var miasto: String?

//: ### Właściwości Klasy
    static fileprivate(set) var liczbaStacjiPogodowych = 0

//: ### [Obserwatory Właściwości](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-ID262) (nie KVO!).
    var zachmurzenie: String {

        // Wywołane przed ustawieniem wartości.
        willSet {
            print("Nowa pogoda będzie: \(newValue)")
        }

        // Wywołane po ustawieniu wartości.        
        didSet(staraPogoda) {
            print("Stara pogoda była: \(staraPogoda)")
        }
    }

//: ### Settery i Gettery
    var tempOrazZach: (temp: Int?, zach: String) {
        get {
            return (temperatura, zachmurzenie)
        }

//: Mamy dostęp do przypisywanej pod stałą o nazwie **newValue**. Możemy też ją sami nazwać podająć jej nazwę w nawiasach za słowem kluczowym **set**.
        set { // 💡: set(nowaTemperaturaOrazNoweZachmurzenie) {
            type(of: newValue)
            temperatura  = newValue.temp
            zachmurzenie = newValue.1
        }
    }

//: Jeżeli mamy tylko getter to można pominąć słowo kluczowe get.

    var temperaturaF : Double? {
        if let temperatura = temperatura {
            return Double(temperatura) * 1.8 + Double(32)
        }
        else {
            return nil
        }
    }

//: ### ["Lenive" właściwości.](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-ID257)
//: W życiu czasem tak się zdaża, że pewne zasoby są dostępne dopiero po tym jak w pełni będzimy pełnoletni. Może też się tak wydarzyć, że nie chcemy płacić kosztu z tworzeniem lub rozpoczynaiem jakiegoś procesu gdy jest on rzadko używany. Korzystając z oznaczenia _właściwości_ jako _leniwej_ (**lazy**) możeby opóźnić wykonanie kodu inicjalizującego do momentu aż ktoś faktycznie z tego nie skorzysta. Blok, który jest użyty do inicjalizacji będzie wywołany tylko raz. Możemy też przypisać takiej zmiennej wartość póżnej (w przeciwieństwie do _wyliczonych właściwości_ ).

    lazy var temperaturaOstatni30Dni: [Int] = {
        var temp: [Int] = []

        print("🍴 Leniwe raz!")
        sleep(opoznienie)
        for _ in 0..<30 {
            temp += [Int(arc4random_uniform(30))]
        }
        print("😱 Matko jak długo!")

        return temp
    }()

//: ## Nil Resetable

    lazy var prowadzaca: String!  = {
        return "Mariana"
    }()

//: ### [iniciajlizacja](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html)
//: W Swift każda klasa musi posiadać __desygnowany initilizer__ jeżeli wszystkie nie opcjonalne właściwości/properties nie mają domyslnie przypisanej wartości. Jeżeli natomiast mają to jest automatycznie generowany pusty initilizer.

    init(maxTemperatura: Int, rodzajDeszczu: String) { // brak 'func'
        self.maxTemperatura = maxTemperatura
        zachmurzenie  = rodzajDeszczu           // można pominąć 'self'

        Pogoda.liczbaStacjiPogodowych += 1
        print(#function + "\tliczbaInstancji: \(Pogoda.liczbaStacjiPogodowych)")
        // 💡 brak zwrwacanej wartosci
    }

//: Pomicnicze initilizery muszą być oznaczone słowem kluczowym __convenience__. Mogą wołać inne pomocnicze "inity" ale nie mogą wołać "initów" z superklasy.
    convenience init(maxTemperatura: Int) {
        self.init(maxTemperatura: maxTemperatura, rodzajDeszczu: "🌧")
//        super.init() // 💥
    }

//: Zanim kompilator zezwoli na odwolanie się do _self_ to instancja musi być w pełni zainicjalizowana. To znaczy wszystkie nie opcjonalne właściwości muszą mieć przypisaną wartość.
    convenience init(maxTemperatura: Int, temperatura: Int) {
//        self.temperatura = temperatura; // 💥

        self.init(maxTemperatura: maxTemperatura)

        self.temperatura = temperatura; // 👍🏻
    }

//: Nie zawsze inicjalizacja obiektu może się udać. Zabraknie pamięciu lub dane wprowadzone do "init"-a nie mają sensu. W takiej sytuacji chcemy pokazać, że jednak coś się nie udało. Służą do tego _fejlujące initializery_ ([dokumentacja](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID224)). Deklaruje je sie dodając **?** za **init**. Dość ciekawym kuriozum jest sytuacja w której jesteśmy pewni, że fejlujący init nigdy nie z fejluje. Wtedy możemy "?" zastąpić **!** i nie otrzymamy wtedy oprionala.

    convenience init?(miasto: String?, temperatura: Int) { // 💡: init!(...
        self.init(maxTemperatura: 1000)

        guard let miasto = miasto , miasto.characters.count > 0 else {
            return nil // Jedyny moment kiedy możemy zwrócić coś w "inicie"
        }

        self.miasto = miasto
    }

    deinit {
        Pogoda.liczbaStacjiPogodowych -= 1
        print(#function + "\tliczbaInstancji: \(Pogoda.liczbaStacjiPogodowych)")
    }

//: ### Metody Instancji
    func raportPogody() -> String {
        var raport = ""

        if let miasto = miasto {
            raport += "Pogoda dla miasta: \(miasto.uppercased())\n"
        }

        if let temperatura = temperatura {
            raport += "\t Temperatura: \(temperatura)\n"
        }

        raport += "\tZachmurzenie: \(zachmurzenie)\n"
        raport += "\t  Wilgotnosc: \(wilgotnosc)\n"

        print(raport)

        return raport
    }

//: Metody Klasowe / Metody Typu
    static func nowaPogoda(_ miasto: String, temperatura: Int, maxTemperatura: Int, wilgotnosc: Int, rodzajDeszczu: String ) -> Pogoda {

        let pogoda = Pogoda.init(maxTemperatura: maxTemperatura, rodzajDeszczu: rodzajDeszczu)
        pogoda.wilgotnosc = wilgotnosc
        pogoda.temperatura = temperatura
        pogoda.miasto = miasto

        return pogoda
    }

} // class Pogoda: MojaKlasa

//: Inaczej jak przy zwykłych funkcjach pierwszy podany argument jest widoczny przy wywołaniu. Jeżeli chcemy aby nie był widoczny w inicie możemy użyć "_" aby sie go pozbyć.
let instancjaPogody = Pogoda(maxTemperatura: 10000)
instancjaPogody.temperatura = 12

let pogodaWMiescie = Pogoda(miasto: "Białystok", temperatura: 42) // 💡: !
type(of: pogodaWMiescie)
pogodaWMiescie

pogodaWMiescie?.temperatura = 24
pogodaWMiescie?.temperatura

instancjaPogody.tempOrazZach = (18, "🌥")
instancjaPogody.tempOrazZach
instancjaPogody.temperaturaF // google: 18 degrees Celsius = 64.4 degrees Fahrenheit

//: ## Test Leniwych

//instancjaPogody.temperaturaOstatni30Dni = [5,10,15] // 💡: zobacz co się stanie pod odkomentowaniu

for temp in instancjaPogody.temperaturaOstatni30Dni {
    temp
}

//: Co się stanie jak zawołam jeszcze raz?
for temp in instancjaPogody.temperaturaOstatni30Dni {
    temp
}

instancjaPogody.temperaturaOstatni30Dni = [5,10,15]
//: Co się stanie jak zawołam jeszcze raz?
for temp in instancjaPogody.temperaturaOstatni30Dni {
    temp
}

instancjaPogody.raportPogody()

do {
    let zFabrykiPogody = Pogoda.nowaPogoda("Zakopane", temperatura: 16, maxTemperatura: 100, wilgotnosc: 66, rodzajDeszczu: "☀️")
    zFabrykiPogody.raportPogody()
}

//: Nil Resetable

instancjaPogody.prowadzaca
instancjaPogody.prowadzaca = nil
instancjaPogody.prowadzaca = "Marta"
instancjaPogody.prowadzaca
instancjaPogody.prowadzaca = nil
instancjaPogody.prowadzaca

print("")
//: ## Klasy Zagnieżdżone
//: Klasy mozemy definiować wewnątrz innej klasy.
opoznienie

class Zewnetrzna {

    class Wewnetrzna {
        init () { print("Wewnetrzna -> 😋 init")}
        deinit { print("Wewnetrzna -> 😵 deinit") }

        func metodaW() {
            print("Wewnetrzna -> 👑 metodaW")
        }
    }

    var wewnetrzna = Wewnetrzna()

    init () { print("Zewnetrzna -> 😋 init")}
    deinit { print("Zewnetrzna -> 😵 deinit") }

    func metodaZ() {
        print("Zewnetrzna -> 💍 metodaZ")
    }

    func metodaZW() {
        wewnetrzna.metodaW()
    }
}


do {
    let z = Zewnetrzna()
    type(of: z)
    z.metodaZ()

//: 💡 Type klasy wewnetrznej jest zwiazany z typem klasy zewnetrznej
    type(of: z.wewnetrzna)

    z.metodaZW()
    z.wewnetrzna.metodaW()
}
print("")

do {
    print("Tworze instancje klasy wewnetrznej:".uppercased())
    let zw = Zewnetrzna.Wewnetrzna()
    type(of: zw)
}

//: A co jeżeli klasa wewnątrz będzie prywatna?

print("\nWewnetrzna Klasa Prywatna".uppercased())
class Zew {

    fileprivate class Wewnetrzna {
        init () { print("Wewnetrzna -> 😋 init")}
        deinit { print("Wewnetrzna -> 😵 deinit") }

        func metodaW() {
            print("Wewnetrzna -> 👑 metodaW")
        }
    }

    fileprivate var wewnetrzna = Wewnetrzna()

//    var wyciagacz: Zew.Wewnetrzna { // 💥
//        return wewnetrzna
//    }

    init () { print("Zew -> 😋 init")}
    deinit { print("Zew -> 😵 deinit") }

    func metodaZ() {
        print("Zew -> 💍 metodaZ")
    }

    func metodaZW() {
        wewnetrzna.metodaW()
    }
}

do {
    let z = Zew()
    type(of: z)
    z.metodaZ()
    z.metodaZW()
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
