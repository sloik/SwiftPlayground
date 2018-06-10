//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Array
import UIKit
//:> ## Tworzenie

//: Tablice przechowuja elementy jednego typu. Jeżeli typ nie zostanie podany to zostanie wydedukowany przez kompilator.
var tablica = ["💩", "⚡️", "😎"]
type(of: tablica)

var tablicaLiczb: [Int] = [1, 42, 69]
type(of: tablicaLiczb)

var tablicaD1 = [Double]() // woła domyślny init na tablicy
type(of: tablicaD1)

var tablicaD2: [Double] = []
type(of: tablicaD2)

var tablicaD3: Array<Double> = [];
type(of: tablicaD3)

var tablicaD4 = Array<Double>()
type(of: tablicaD4)

//: Możemy określić domyślną wartość przechowywanego elementu oraz początkowy rozmiar tablicy.
var tablica💩 = Array(repeating: "💩", count: 5)
type(of: tablica💩)

var zakazaneLiczby = [Int](repeating: 6, count: 3) // jeżeli typy się nie zgadzają to 💥
type(of: zakazaneLiczby)

/*:
Jest możliwe (nie zalecane) tworzenie tablic mogących trzymać różne obiekty/wartości.
* **Any**: Dowolny obiekt lub wartość.
* **AnyObject**: Dowolny obiekt.

[Wiecej o Any i AnyObject oraz kiedy używać jakiego tutaj...](https://developer.apple.com/library/prerelease/mac/documentation/Swift/Conceptual/Swift_Programming_Language/TypeCasting.html#//apple_ref/doc/uid/TP40014097-CH22-ID342)
*/

var tablicaCzegokolwiek: [Any] = [1, 2.0, "😜", UIView()] // podanie [Any] czasem może być wymagane
type(of: tablicaCzegokolwiek)

var tablicaObiektow: [AnyObject] = [1 as AnyObject, 2.0 as AnyObject, "😜" as AnyObject, UIView()]
type(of: tablicaObiektow)

//: Tablice mogą przechowywać __optionale__ oraz same byc __optionalami__.

var cytat = "Niebo w ziemi."
var bycMozeCytat : String? = nil;

var tablicaStringow = [cytat, bycMozeCytat]
type(of: tablicaStringow)

var opcjonalnaTablica : [String]?
type(of: opcjonalnaTablica)

var opcjonalnaTablicaOpcjonalnychStringow : [String?]?
type(of: opcjonalnaTablicaOpcjonalnychStringow)

//: ## Inspekcja
tablica
// ilość elementów w tablicy
tablica.count

// czy jest pusta
tablica.isEmpty

// czy zawiera element
tablica.contains("💩")

//: Tablice są indexowane od `0` i w przeciwieństwie do Stringów (he he) indexy **są** liczbami całkowitymi.
var index: Int = 1
var element = tablica[index]
//var wartoscPoZaZakresemTablicy = tablica[100] // 💥

var pierwszyElement = tablica.first
type(of: pierwszyElement)

var ostatniElement = tablica.last
type(of: ostatniElement)

//: Możemy też tworzyć __wycinki__ tablicy przy wykorzystaniu zakresów.
tablica
var gownoBurza = tablica[0..<2]
type(of: gownoBurza)

tablica[...1]
tablica[..<1]
tablica[1...]

//: ### Sortowanie
var losowa = ["d", "c", "z", "q", "a"]
losowa.sort()
losowa
losowa.sort(by: >)
losowa

losowa.sort()
losowa

//: ## Modyfikacja

let oryginalnaTablica = tablica

//: używając indexu
tablica[1] = "⛈"
tablica

tablica.append("☀️")

let usunietyElement = tablica.removeLast()
tablica

tablica.insert(usunietyElement, at: 0)

//: Dodawanie Tablic (kolejność jest zachowana zgodnie z kolejnością dodawania).

var imiona = ["Ania", "Kasia", "Basia"];
var zakupy = ["Mleko", "Jajka", "Bekon"];

var imionaZakupy = imiona + zakupy;
imionaZakupy = imiona + ["Ser"]

var liczby : [Int] = []

for index in 0..<5 {
    liczby += [index]
}

liczby

//: ## Zagnieżdzenie
var tablicaTablicStringow =
[
    ["Lorem", "Ipsum", "Sit", "Dolor", "Mint", "Ament"],
    oryginalnaTablica
]

tablicaTablicStringow
type(of: tablicaTablicStringow)

let tablicaEmoji = tablicaTablicStringow[1]

let emoji = tablicaTablicStringow[1][0]

//: [Jak działa FlatMap](http://sketchytech.blogspot.com/2015/06/swift-what-do-map-and-flatmap-really-do.html)
let wszystkieElementy = tablicaTablicStringow.flatMap({ $0 })
wszystkieElementy

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
