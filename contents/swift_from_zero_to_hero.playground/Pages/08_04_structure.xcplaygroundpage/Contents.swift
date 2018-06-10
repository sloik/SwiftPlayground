//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Struktury
/*: 
Struktury są niemal identyczne z klasami. Mogą:
* adoptować protokoły,
* posiadać właściwości, 
* metody, 
* można je rozszerzać,
* posiadają initializery

To co je odróżnia to:
* są przekazywane przez kopie/warość,
* nie mogą dziedziczyć,
* nie mają deinitializera,
* jeżeli nie ma zdefiniowanego initializera to jest generowany przez kompilator
*/

import Foundation

/*: 
Kod jest w 99% identyczny jak na stronie z Klasami.
*/

struct PogodaKlasa {

    var temperatura: Int?
    var wilgotnosc = 78
    let maxTemperatura:Int
    var miasto: String?

    static fileprivate(set) var liczbaStacjiPogodowych = 0

    var zachmurzenie: String {

        willSet {
            print("Nowa pogoda będzie: \(newValue)")
        }

        didSet(staraPogoda) {
            print("Stara pogoda była: \(staraPogoda)")
        }
    }

    var tempOrazZach: (temp: Int?, zach: String) {
        get { return (temperatura, zachmurzenie) }

        set {
            type(of: newValue)
            temperatura  = newValue.temp
            zachmurzenie = newValue.1
        }
    }

    var temperaturaF : Double? {
        if let temperatura = temperatura { return Double(temperatura) * 1.8 + Double(32) }
        return nil
    }

    lazy var temperaturaOstatni30Dni: [Int] = {
        var temp: [Int] = []

        print("🍴 Leniwe raz!")
        sleep(5)
        for _ in 0..<30 {
            temp += [Int(arc4random_uniform(30))]
        }
        print("😱 Matko jak długo!")

        return temp
    }()

    init(maxTemperatura: Int, rodzajDeszczu: String) { 
        self.maxTemperatura = maxTemperatura
        zachmurzenie        = rodzajDeszczu       

        PogodaKlasa.liczbaStacjiPogodowych += 1
        print(#function + "\tliczbaInstancji: \(PogodaKlasa.liczbaStacjiPogodowych)")
    }

    init(maxTemperatura: Int) { // 💡 brak convenience
        self.init(maxTemperatura: maxTemperatura, rodzajDeszczu: "🌧")
    }


    init(maxTemperatura: Int, temperatura: Int) { // 💡 brak convenience
        self.init(maxTemperatura: maxTemperatura)
        self.temperatura = temperatura;
    }

     init?(miasto: String?, temperatura: Int) { // 💡 brak convenience
        self.init(maxTemperatura: 1000)

        guard let miasto = miasto , miasto.characters.count > 0 else {
            return nil // Jedyny moment kiedy możemy zwrócić coś w "inicie"
        }

        self.miasto = miasto
    }

//    deinit {} // 💥

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

    static func nowaPogoda(_ miasto: String, temperatura: Int, maxTemperatura: Int, wilgotnosc: Int, rodzajDeszczu: String ) -> PogodaKlasa {
        
        var pogoda = PogodaKlasa.init(maxTemperatura: maxTemperatura, rodzajDeszczu: rodzajDeszczu)
        pogoda.wilgotnosc = wilgotnosc
        pogoda.temperatura = temperatura
        pogoda.miasto = miasto
        
        return pogoda
    }
}

//: ---

protocol Pogodynka {}

struct MojaStruktura: Pogodynka {
    var klaatu: String
    var barada: Int
    var nikto : Double
}

let strukturkaMoja = MojaStruktura(klaatu: "klaatu", barada: 42, nikto: 6.9)
//strukturkaMoja.klaatu = "Klaatu" // 💥

//: Domyślne metody struktury nie mogą jej zmienić ani żadnej innej właściwości.

struct Pogoda {
    var temperatura: Int
    var wilgotnosc: Int

    func ustawWilgotnosc(_ nowaWilgotnosc: Int) {
//        wilgotnosc = nowaWilgotnosc // 💥
    }

    func domyslnaPogoda() {
//        self = Pogoda() // 💥
    }

    mutating func mutujWilgotnosc(_ zmutowanaWilgotnosc: Int) {
        wilgotnosc = zmutowanaWilgotnosc // 👍🏻
    }
}


let stalaPogoda = Pogoda(temperatura: 42, wilgotnosc: 69)
//stalaPogoda.mutujWilgotnosc(96) // 💥

var zmiennaPogoda = stalaPogoda
zmiennaPogoda.mutujWilgotnosc(96) // 👍🏻

stalaPogoda.wilgotnosc
zmiennaPogoda.wilgotnosc

//: Struktury mogą być użyte do tworzenia "błędów". W rozdziale o [obsłudze błędów](07_04_obsluga_bledow) był do tego celu użyty enum.

enum CosWybuchlo: Error {
    case mialesPecha
    case zwarcie(kod: Int, nazwaFunkcji: String, linijka: Int)
}

struct Zwarcie: Error  {
    let kod: Int
    let nazwaFunkcji: String
    let linijka: Int
}

func mozeWybuchnac() throws {
    throw Zwarcie(kod: 69, nazwaFunkcji: #function, linijka: #line)
}

do {
    try mozeWybuchnac()
}
//catch {
//    error.dynamicType
//}
catch let error as Zwarcie { // Castowanie jest wymagane
    error.kod
    error.nazwaFunkcji
    error.linijka
}

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
