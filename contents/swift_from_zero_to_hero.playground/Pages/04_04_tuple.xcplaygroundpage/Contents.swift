//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Tuple
/*:
 * [🇵🇱 Swift od zera do bohatera! Tuple / Krotka - Tworzenie](https://www.youtube.com/watch?v=xfFUHpWEq0s&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=12)
 
  * [🇵🇱 Swift od zera do bohatera! Tuple / Krotka - Modyfikacja](https://www.youtube.com/watch?v=3U7zRKWSQkk&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=13)
 */
//: "Tuples are useful for temporary groups of related values. (…) If your data structure is likely to persist beyond a temporary scope, model it as a class or structure (…) "
//:         -- Dokumentacja

//: ## Tworzenie
let httpStatus200 = (200, "👍🏻")
type(of: httpStatus200)

let httpStatus404: (Int, String, String) = (404, "😱", "nie mam pojecia gdzie to jest")
type(of: httpStatus404)

let nazwany: (kod: Int, poNaszemu: String) = (200, "👍🏻")
type(of: nazwany)

let nazwany2 = (kod: 200, wiadomosc: "Ok")
type(of: nazwany2)

let pustyTuplet: () = ()
type(of: pustyTuplet)
type(of: pustyTuplet) == Void.self // typealias Void = ()
Void.self

var opcjonalnyTuplet: (Float, Int)?
type(of: opcjonalnyTuplet)

//: Jednoelementowy tuplet

var tupletJednoelementowy: (Int) = (69)
type(of: tupletJednoelementowy) // 💥⚡️
//tupletJednoelementowy.0 // 💥

//var tupletJednoelementowy2: (x: Int) = 69 // 💥


//: Tu naukowcy się jeszcze spoerają czy się da czy się nie da ;)

//: ## Inspekcja
httpStatus200
httpStatus200.0
httpStatus200.1

nazwany.kod
nazwany.poNaszemu

//: Dekompozycja
httpStatus200

let (status, emoji) = httpStatus200
status
emoji

httpStatus404
let dekompozycja: (status: Int, emoji: String, dlaCzlowieka: String) = httpStatus404
dekompozycja.status
dekompozycja.emoji
dekompozycja.dlaCzlowieka

let (kodHTTP, _, dlaCzlowieka) = httpStatus404
kodHTTP
dlaCzlowieka

var pogodaGodzinowo = (12, (wilgotnosc: "90 %", temperatura: "14 stopni C"))
type(of: pogodaGodzinowo) // Zagnieżdzenie

pogodaGodzinowo.0
pogodaGodzinowo.1.wilgotnosc

var pogodaGodzinowo2 = (13, pogoda: (wilgotnosc: "60 %", temperatura: "21 stopni C"))
pogodaGodzinowo2.pogoda.temperatura

var pogodaGodzinowo3 = (godzina: 14, pogoda: (wilgotnosc: "78 %", temperatura: "32 stopni C"))
pogodaGodzinowo3.pogoda.wilgotnosc
pogodaGodzinowo3.godzina

//: ## Modyfikacja
var pogodaGodzinowo4 = pogodaGodzinowo3
pogodaGodzinowo4.godzina = 15
pogodaGodzinowo4.pogoda.wilgotnosc = "66 %"
pogodaGodzinowo4.1.temperatura = "-5 stopni C"

pogodaGodzinowo3
pogodaGodzinowo4

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
