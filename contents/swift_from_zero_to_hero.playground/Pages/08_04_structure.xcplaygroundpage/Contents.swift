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

struct WeatherStructure {

    var temperature: Int?
    var humidity = 78
    let maxTemperature:Int
    var city: String?

    static fileprivate(set) var numberOfWeatherStations = 0

    var overcast: String {

        willSet {
            print("Nowa pogoda będzie: \(newValue)")
        }

        didSet(staraPogoda) {
            print("Stara pogoda była: \(staraPogoda)")
        }
    }

    var tempAndOvercast: (temp: Int?, overcast: String) {
        get { return (temperature, overcast) }

        set {
            type(of: newValue)
            temperature  = newValue.temp
            overcast = newValue.1
        }
    }

    var temperatureF : Double? {
        if let temperature = temperature { return Double(temperature) * 1.8 + Double(32) }
        return .none
    }

    lazy var temperatureLast30Days: [Int] = {
        var temp: [Int] = []

        print("🍴 Leniwe raz!")
        sleep(5)
        for _ in 0..<30 {
            temp += [Int(arc4random_uniform(30))]
        }
        print("😱 Matko jak długo!")

        return temp
    }()

    init(maxTemperature: Int, rainType: String) {
        self.maxTemperature = maxTemperature
        overcast        = rainType

        WeatherStructure.numberOfWeatherStations += 1
        print(#function + "\tliczbaInstancji: \(WeatherStructure.numberOfWeatherStations)")
    }

    init(maxTemperature: Int) { // 💡 brak convenience
        self.init(maxTemperature: maxTemperature, rainType: "🌧")
    }


    init(maxTemperature: Int, temperature: Int) { // 💡 brak convenience
        self.init(maxTemperature: maxTemperature)
        self.temperature = temperature;
    }

     init?(city: String?, temperature: Int) { // 💡 brak convenience
        self.init(maxTemperature: 1000)

        guard let city = city, city.count > 0 else {
            return nil // Jedyny moment kiedy możemy zwrócić coś w "inicie"
        }

        self.city = city
    }

//    deinit {} // 💥

    func weatherReport() -> String {
        var report = ""

        if let city = city {
            report += "Pogoda dla miasta: \(city.uppercased())\n"
        }

        if let temperature = temperature {
            report += "\t Temperatura: \(temperature)\n"
        }

        report += "\tZachmurzenie: \(overcast)\n"
        report += "\t  Wilgotnosc: \(humidity)\n"

        print(report)

        return report
    }

    static func newWeather(_ city: String, temperature: Int, maxTemperature: Int, humidity: Int, rainType: String ) -> WeatherStructure {
        
        var pogoda = WeatherStructure(maxTemperature: maxTemperature, rainType: rainType)
        pogoda.humidity = humidity
        pogoda.temperature = temperature
        pogoda.city = city
        
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
