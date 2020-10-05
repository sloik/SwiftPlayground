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
* są przekazywane przez kopie/wartość,
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
            temp += [ Int.random(in: 0...30)]
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

    // 💥 Deinitializers may only be declared within a class
//    deinit {}

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
        
        var weather = WeatherStructure(maxTemperature: maxTemperature, rainType: rainType)
        weather.humidity = humidity
        weather.temperature = temperature
        weather.city = city
        
        return weather
    }
}

//: ---

protocol WeatherAnchor {}

struct MyStructure: WeatherAnchor {
    var klaatu: String
    var barada: Int
    var nikto : Double
}

let structureInstance = MyStructure(klaatu: "klaatu", barada: 42, nikto: 6.9)

// 💥 Cannot assign to property: 'structureInstance' is a 'let' constant
// Change 'let' to 'var' to make it mutable
//structureInstance.klaatu = "Klaatu"

//: Domyślne metody struktury nie mogą jej zmienić ani żadnej innej właściwości.

struct Weather {
    var temperature: Int
    var humidity: Int

    func setHumidity(_ newHumidity: Int) {
        // 💥 Cannot assign to property: 'self' is immutable
//        humidity = newHumidity
    }

    func defaultWeather() {
        // 💥 Cannot assign to value: 'self' is immutable
//        self = Weather(temperature: 21, humidity: 69)
    }

    mutating func mutateHumidity(_ newHumidity: Int) {
        humidity = newHumidity // 👍🏻
    }
}


let constantWeather = Weather(temperature: 42, humidity: 69)
// 💥 Cannot use mutating member on immutable value: 'constantWeather' is a 'let' constant
//constantWeather.mutateHumidity(96)

var variableWeather = constantWeather
variableWeather.mutateHumidity(96) // 👍🏻

constantWeather.humidity
variableWeather.humidity

//: Struktury mogą być użyte do tworzenia "błędów". W rozdziale o [obsłudze błędów](07_04_obsluga_bledow) był do tego celu użyty enum.

struct ShortCircuit: Error  {
    let code: Int
    let functionName: String
    let line: Int
}

func mayExplode() throws {
    throw ShortCircuit(code: 69, functionName: #function, line: #line)
}

do {
    try mayExplode()
}
//catch {
//    error.dynamicType
//}
catch let error as ShortCircuit { // Castowanie jest wymagane
    error.code
    error.functionName
    error.line
}

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)

print("🦄")
