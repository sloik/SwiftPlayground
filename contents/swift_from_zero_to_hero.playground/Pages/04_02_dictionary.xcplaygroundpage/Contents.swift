//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Dictionary
/*:
 * [🇵🇱 Swift od zera do bohatera! Swift Dictionary Słownik - Tworzenie i Inspekcja](https://www.youtube.com/watch?v=8PGsSV4W2KY&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=8)
  * [🇵🇱 Swift od zera do bohatera! Słownik Modyfikacja i Inne Smaczki](https://www.youtube.com/watch?v=0K5EZL_xWwA&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=9)
 */
//: ## Tworzenie
var emojiNaNasze = ["💩" : "kupka",
                    "🍻" : "piwo"]
type(of: emojiNaNasze)

var noty: [String:Int] = [:]
type(of: noty)

var noty2 = Dictionary<String, Int>()
type(of: noty2)

//: Klucze w słowniku nie mogą byc opcjonalne oraz muszą implemetować protokół __Hashable__.

var bycMozeEmoji : String? = nil
//emojiNaNasze = [bycMozeEmoji : "kto wie co"] // 💥

//: Możemy też tworzyć słownik z tupli.
let miasta = ["Warszawa", "Krakow"]
let ludnosc = [1.6, 1.1]

Dictionary(uniqueKeysWithValues: zip(miasta, ludnosc))

//: Możemy też tworząc słowniki grupować je
let stringi = ["a", "bb", "ccc", "d", "ee", "fff", "gggg"]

let nowySlownik =
Dictionary(grouping: stringi) { $0.count }

let nowyslownik2 =
Dictionary(grouping: stringi) { $0.first! }

//: ## Inspekcja

let klucze   = Array(emojiNaNasze.keys)
let wartosci = Array(emojiNaNasze.values)

emojiNaNasze
let wartoscDlaEmoji = emojiNaNasze["💩"]
type(of: wartoscDlaEmoji)

//: Jeżeli nie ma wartości dla naszego klucza możemy zdefiniować wartość domyślną, która ma być użyta.
emojiNaNasze["😱", default: "ja pierdziu"]
//: ## Modyfikacja
emojiNaNasze
emojiNaNasze["⛈"] = "burza"
emojiNaNasze

emojiNaNasze["💩"] = "usmiechnieta kupka"
emojiNaNasze

emojiNaNasze["💩"] = nil
emojiNaNasze

let usunietyElement = emojiNaNasze.removeValue(forKey: "⛈")
type(of: usunietyElement)

emojiNaNasze.removeAll()

//: Możemy też mergujac slowniki zdecydowac jak maja byc rozwiazane konflitky.

let daneA = ["Lorem": 1, "ipsum": 2]
let daneB = ["ipsum": 3, "sit": 4]

daneA.merging(daneB, uniquingKeysWith: +)

let duplikaty = [("a", 1), ("b", 2), ("a", 3), ("b", 4), ("b", 5)]

var result =
Dictionary(duplikaty, uniquingKeysWith: { (first, _) in first })

result =
Dictionary(duplikaty, uniquingKeysWith: { (_, last) in last })
result

//: ## Iteracja
emojiNaNasze = ["💩" : "kupka", "🍻" : "piwo"]
for (key, value) in emojiNaNasze {
    (key, value)
}

let mapped = emojiNaNasze.mapValues{$0 + " nasze"}
mapped

//: ## Zagnieżdzenie

var pogodaGodzinowo : [Int: [String: String]] =
[
    12: [
        "temperatura": "12 stopni C",
        "wilgotnosc" : "80 %"
    ],
    13: [
        "temperatura": "18 stopni C",
        "wilgotnosc" : "90 %"
    ]
]
type(of: pogodaGodzinowo)

//: Ponieważ każda zwracana wartość jest optionalem to musimy skorzystać z funkcji Swifta nazwanej __[Optional Chaining](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/OptionalChaining.html)__ aby dobrać się do głębiej zagnieżdzonych wartości. Mechanizm działa tak, że `zejdzie` niżej tylko w wypadku gdy wartość istnieje.
let wilgotnoscGodz13 = pogodaGodzinowo[13]?["wilgotnosc"]
type(of: wilgotnoscGodz13)

//: ## Filtrowanie
let jakiesDane = ["a": 1, "b": 2, "c": 3]
let wynikFiltrowania = jakiesDane.filter { $0.value > 1 }
type(of: wynikFiltrowania)
type(of: jakiesDane)


//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
