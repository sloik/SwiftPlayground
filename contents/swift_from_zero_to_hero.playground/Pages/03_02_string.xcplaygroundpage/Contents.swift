//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## String
import Foundation
//: ### Definiowanie
//: Stringi są przekazywane przez kopie
var cytat = "Sorry będziesz to jeść?"
var nowyCytat = cytat

nowyCytat = "Niebo w ziemi."

cytat

let wielolinijkowiec =
    """
    Wiele linijek sie przydaje \\
    Wazne jest natomiast aby wszystkie \
    Zaczynaly sie ta sama iloscia bialych znakow.
    """
wielolinijkowiec
//: Można je tworzyć również przez __interpolacje__.
let jakisTekst = "lorem ipsum"
let jakasLiczba = 42.6969

print("Interpolacja pozwala nam bezpośrednio wstawić: \"\(jakisTekst)\" oraz \"\(jakasLiczba)\"")

//: Można też używać formaterów [mozliwe formatery](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html)
print(String(format:"Interpolacja pozwala nam bezpośrednio wstawić: \"%@\" oraz \"%.2f\"", jakisTekst, jakasLiczba))

//: ### Inspekcja
cytat
cytat.hasPrefix("Sorry będziesz")
cytat.hasSuffix("-- Edward")

"👩‍💻".count
"👍🏽".count
"👨‍❤️‍💋‍👨".count 

//: Liczba znaków
cytat.count

//: Indexy wyglądają jak liczby całkowite ale nimi nie są!💥
cytat.startIndex
cytat.endIndex

let unicode1 = "\u{61}\u{301}\u{20DD}"
let unicode2 = "\u{E1}\u{20DD}"

unicode1.endIndex
unicode2.endIndex // wskazanie na index __za__ stringiem

unicode1.count

unicode2.count

unicode1 == unicode2

//: Przykład uzycia indexów
cytat
let pierwszyZnak = cytat[cytat.startIndex]
let drugiZnak    = cytat[cytat.index(after: cytat.startIndex)]
let trzecuZnak   = cytat[cytat.index(after: cytat.index(after: cytat.index(after: cytat.startIndex)))]

let indexSiodmegoZnaku = cytat.index(cytat.startIndex, offsetBy: 6)
let siodmyZnak = cytat[indexSiodmegoZnaku]

let ostatniZnak = cytat[cytat.index(before: cytat.endIndex)]

//: ### Modyfikacja

cytat.uppercased()
cytat.lowercased()
cytat
"abc".dropFirst(2)
"abc".dropLast(2)

var nowszyCytat = "Można pić bez obawień."
nowszyCytat.remove(at: nowszyCytat.index(before: nowszyCytat.endIndex))
nowszyCytat

nowszyCytat.insert("!", at: nowszyCytat.endIndex)
nowszyCytat

let przykładowyZakres = 0..<42

let poczatkowyIndex = nowszyCytat.index(nowszyCytat.startIndex, offsetBy: 6);
let koncowyIndex = nowszyCytat.index(poczatkowyIndex, offsetBy: 3)
let zakres = poczatkowyIndex..<koncowyIndex

nowszyCytat
nowszyCytat.replaceSubrange(zakres, with: "chlać")

/*:
### Stałe znakowe
* `\n` - nowa linia / koniec lini (`\r` )
* `\t` - tabulacja
* `\`  - escape `\` oraz `"`
* `\0` - pusty znak
*/

print("\"Można pić bez obawień!\"\n\t\t-- Wiesław Wszywka")

"\0".isEmpty
"".isEmpty

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
