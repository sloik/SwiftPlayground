//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## In-Out, Przekazywanie Typów Referencyjnych, Przekazywanie/Zwracanie Funkcji, Zagnieżdzone Funkcje

import UIKit

//: Parametry przekazywane są jako stałe.

var liczba = 42

//: [Wiecej atrybutów do @available](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Attributes.html)
@available(*, introduced: 1.2, deprecated: 2.0, message: "ta metoda wybucha, użyj lepiej bierzeIntaJakoZmienna")
func bierzeInta(_ parametr:Int) {
    //    parametr -= 2 // 💥
}

bierzeInta(liczba)

liczba

func bierzeIntaJakoZmienna(_ liczba:Int) {
    var liczba = liczba
    liczba -= 2
}

bierzeIntaJakoZmienna(liczba) // przkazna jest kopia
liczba

//: ### In - Out
//: Aby móc zmienić przekazny parametr musimy użyć słowa kluczowego __inout__ .

func bierzeIntOrazGoZmienia(_ liczba: inout Int) {
    guard liczba >= 2 else {
        return
    }

    liczba -= 2
}

liczba = 42
bierzeIntOrazGoZmienia(&liczba)
liczba

//: Przydatną praktyką jest komentowanie metod. Dzieki temu w __Quick help__ będziemy mogli zobaczyć bardzo użyteczny opis.

/**
Przykładowa metoda służąca do pokazania w jaki sposób dodany komentarz pojawia się w podręcznej pomocy. Dobrą praktyką jest dokumentowanie co robi dana funkcja i czego się po niej można spodziewać.

- parameter wejsciowy: Przykładowy parametr wejściowy, zostanie zwrócony jako pierwszy w tuplecie.
- parameter liczba:    Przykładowy parametr wejściowy, zostanie zwrócony jako drugi w tuplecie.

- returns: Zwraca krotkę składającą się z przekazanych parametrów.
*/
func metodaDoUdokumentowania(_ wejsciowy: String, liczba: Int) -> (wej: String, licz: Int) {
    return (wejsciowy, liczba)
}

let czyToDziała = metodaDoUdokumentowania("sprawdzam", liczba: 69)
czyToDziała.wej
czyToDziała.1

//: ## Przekazywanie Typów Referencyjnych
//: W tym wypadku w argumencie funkcji dostaniemy referencje ("wskazanie") do obiektu a nie jego kopie.

let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
let widok = UIView(frame: frame)
widok.backgroundColor = UIColor.red
Unmanaged.passUnretained(widok).toOpaque()
widok

func przyjmujeWidok(_ parametrWidok: UIView) {
    Unmanaged.passUnretained(parametrWidok).toOpaque()
    widok.backgroundColor = UIColor.green

    //    parametrWidok = UIView() // 💥
}

przyjmujeWidok(widok)

widok

//: Mimo, że __widok__ jest zdefiniowany jako stała (__let__) to ponieważ jest przekazany przez referencję wewnątrz funkcji można zmienić jego __nie stałe__ atrybuty.
//: > Natomiast gdy przekażemy do funkcji referencje (typ referencyjny) i dodatkowo ten parametr jest __inout__ to wtedy wewnątrz funkcji będziemy mogli całkowicie podmienić obiekt na zupełnie nowy.

func przyjmujeWidokInOut(_ widok: inout UIView) {

    widok = UIView(frame: CGRect(x: 0,y: 0, width: 50, height: 50))
    widok.backgroundColor = UIColor.lightGray
}

var testowyWidok = UIView(frame: frame)
testowyWidok.backgroundColor = UIColor.yellow
testowyWidok

let referencjaPrzed = Unmanaged.passUnretained(testowyWidok).toOpaque()

przyjmujeWidokInOut(&testowyWidok)

let referencjaPo = Unmanaged.passUnretained(testowyWidok).toOpaque()

testowyWidok

referencjaPrzed == referencjaPo

//: ## Przekazywanie Funkcji Jako Argumentu Do Funkcji

func dodajLiczby(_ a: Int, _ b:Int) -> Int {
    return a + b
}
type(of: dodajLiczby)

func wykonajOperacje(_ operacja: (Int, Int) -> Int, l1: Int, l2: Int) -> Int {
    return operacja(l1, l2)
}

let wynik = wykonajOperacje(dodajLiczby, l1: 40, l2: 2)
wynik

//: ## Zwracanie Funkcji i Zagnieżdżanie Funkcji
//: Funkcje mogą zwracać funkcje. Wtedy ich zwracany typ to typ zwracanej funkcji. Jeden przykład jest wart tysiąca słów...

func zapodajCytat() -> (() -> String) { // ... -> () -> String

    func zwracaCytat() -> String {
        return "Można pić bez obawień"
    }
    type(of: zwracaCytat)

    return zwracaCytat
}

let jakasFunkcja = zapodajCytat()
type(of: jakasFunkcja)

jakasFunkcja()

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
