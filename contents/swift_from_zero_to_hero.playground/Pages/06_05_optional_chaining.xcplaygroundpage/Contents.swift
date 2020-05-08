//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
/*:
 # [Optional Chaining](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/OptionalChaining.html)
 
 Optional czyli typ, który mówi nam, że jakiejś wartości może zabraknąć jest bardzo powszechny. Często w życiu czegoś brakuje albo może zabraknąć. Nie jest to też pierwszy raz kiedy się z nim spotykamy.
 
 Swift daje nam mechanizm _optional binding_u który pozwala nadać czemuś nazwę jeżeli wartość istnieje. Widzieliśmy to wiele razy. Natomiast co w sytuacji gdzie to coś czego może nam zabraknąć też ma opcjonalne wartości?
 
 Zbudujemy informacje o pogodzie za pomocą tych stuktóre, które już znamy: słowniki, krotki i tablice.
 */

let optionalWeatherData: [String: (temperature: Int?, humidity: String?)?]?
type(of: optionalWeatherData)

/*:
 Więc cóż to za koszmarek. Mam:
 * opcjonalny słownik z kluczami typu String
 * wartościami są *opcjonalne tuplety**
 * których pierwsza wartość to Opcjonalny Int
 * druga wartość to opcjonalny String
 
 Niech jakieś dane będą w tym słowniku:
 */

optionalWeatherData =
[
    "Białystok" : (temperature: 14, humidity: "70%"),
    "Warszawa"  : nil,
    "Suwałki"   : (temperature: nil, humidity: "80%")
]

/*:
 Jak widać czasem nam brakuje różnych informacji. Teraz gdybyśmy chcieli sprawdzić pogodę w Białymstoku za korzystając z `if let` to kod wyglądałby tak:
 */
let city = "Białystok"

if let weatherData = optionalWeatherData { // we have data
    type(of: weatherData)
    type(of: weatherData[city])
    
    // Optional Optional! Madness!
    
    if let optionalCityEntry = weatherData[city] { // we have a key in a dictionary
        type(of: optionalCityEntry)

        if let cityEntry = optionalCityEntry { // we have an entry
            type(of: cityEntry)
            
            if let temperature = cityEntry.temperature { // we have temperature
                print("🌟", #line, city, "has", temperature, "C")
            } else {
               print("🛤", #line, "Missing temperature for:", city)
            }
            
            if let humidity = cityEntry.humidity { // we have humidity
                print("💦", #line, city, "has", humidity, "C")
            } else {
               print("🛤", #line, "Missing humidity for:", city)
            }
            
        } else {
            print("🛤", #line, "Missing entry:", city)
        }
    } else {
        print("🛤", #line, "Missing city:", city)
    }
} else {
    print("🛤", #line, "No weather data!")
}

/*:
 Polecam uruchomić ten kod dla innych miast aby zobaczyć jak działa. Natomiast na pewno jest to mało czytelny kod! Jednak struktura zwracanych danych i API z jakiego korzystamy sprawia, że **na każdym poziomie MUSIMY** handlować potencjalny brak wartości. Prawda jest taka, że w innym języku aby aplikacja się nie wywalała trzeba by to było tak napisać. Tak czyli sprawdzić każdą możliwą ścieżkę kiedy może nie być wartości. Więc pod **tym względem jest to BARDZO DOBRY kod**.
 
 Całe szczęście nie jesteśmy skazani na coś takiego. Swift daje właśnie mechanizm **Optional chaining**-u.
 
 Dla przypomnienia z czym walczymy na każdym poziomie:
 */

let tempInCity = optionalWeatherData?[city]??.temperature
type(of: tempInCity)

/*:
 Plac zabaw nas trochę oszukuje wypisując wartość. Jednak wypisując typ widać, że pracujemy dalej z Optional-em. Jednak teraz już tylko na jednym poziomie! I możemy posłużyć się dalej optional binding-iem.
 */

if let temperature = optionalWeatherData?[city]??.temperature {
    print("🌟", #line, city, "has", temperature, "C")
} else {
    print("🛤", #line, "Missing temperature for:", city)
}

if let humidity = optionalWeatherData?[city]??.humidity {
    print("💦", #line, city, "has", humidity, "C")
} else {
   print("🛤", #line, "Missing humidity for:", city)
}

/*:
 Prawda, że znacznie lepiej! Znakiem zapytania `?` mówimy: _daj mi wartość jak jest a jak nie to nic nie rób_. Jeżeli potrzebujemy tych wartości razem to nawet można je skleić w jeden `if let`. Gdy trzeba się było dobrać do Opcjonalnego Optional-a to przez każdy poziom przedzieraliśmy się dodając jeszcze jeden znak zapytania: `??`. Gdyby to był Opcjonalny Opcjonalny Opcjonalny... to by dochodziły kolejne `?`. Zasada dla `guard let` jest identyczna jak dla `if let`.
 */

if
    let temperature = optionalWeatherData?[city]??.temperature,
    let humidity = optionalWeatherData?[city]??.humidity{
    print("🌟", #line, city, "has", temperature, "C")
     print("💦", #line, city, "has", humidity, "C")
} else {
    print("🛤", #line, "Missing temperature for:", city)
    print("🛤", #line, "Missing humidity for:", city)
}

/*:
  Optional chaining to nie jedyny sposób aby się dobrać do wartości owiniętej w Optional. Natomiast chyba jest najczęściej spotykany. Tak więc warto przyzwyczaić się do tych `?` bo będziesz oglądać i pisać je bardzo często.
 */



//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
