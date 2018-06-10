//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Reference and Value Types

/*:
# Typy Wartościowe
## Struktury
* Typy Całkowite (Integers)
* Zmienno przecinkowe
* Booloskie
* Stringi 😉
* Tablice
* Słowniki
* Krotki (Tuplety)
## Enumeracje
* Opcjonale
*/
/*:
# Typy Referencyjne
* Klasy
* Funkcje
* Domknięcia/Lambdy/Bloki
*/

/*:
# Różnice między typami

Typy wartościowe są przekazywane przez kopię. To znaczy, że jest tworzony nowy obiekt w momencie w którym jest dokonywane przypisanie do nowej zmiennej.
*/

//: Typ Wartościowy
var tablica = ["🐷", "🐶", "🍰"]
var tuBedzieKopia = tablica
tuBedzieKopia

//: Swift jest na tyle cwany, że kopie tablicy utworzy dopiero w momencie gdy istnieje prawdopodobieństwo zmiany elementów w tablicy.
getBufferAddress(tablica)
getBufferAddress(tuBedzieKopia)

//tablica.append("🍻")
tablica

tuBedzieKopia // jezeli zmianie ulegla 'tablica'

getBufferAddress(tablica) 
getBufferAddress(tuBedzieKopia)

tuBedzieKopia.append("💩")

tablica
getBufferAddress(tablica)
getBufferAddress(tuBedzieKopia)
//: Typ Referencyjny
import UIKit

var widok = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
widok.backgroundColor = .red

var nowaReferencjaDoWidoku = widok
nowaReferencjaDoWidoku.backgroundColor = .green

widok
Unmanaged.passUnretained(widok).toOpaque()
Unmanaged.passUnretained(nowaReferencjaDoWidoku).toOpaque()

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
