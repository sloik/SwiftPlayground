//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Bloki / Lambdy / Funkcje Anonimowe

import Foundation

//: Funkcje w Swift to tak naprawdę specjalne przypadki bloków. Same w sobie są _blokiem_ kodu który możemy użyć bezpośrednio, przekazać jako parametr lub przechować w zmiennej aby wywołać w bardziej odpowiednim czasie (lub dla czytelności kodu). 

let ipsum = "Drogi Marszałku, Wysoka Izbo. PKB rośnie. Różnorakie i określenia modelu rozwoju. W związku z powodu kolejnych kroków w kształtowaniu odpowiednich warunków administracyjno-finansowych. Już nie trzeba udowadniać, ponieważ zakup nowego sprzętu pomaga w tym zakresie zabezpiecza udział szerokiej grupie w restrukturyzacji przedsiębiorstwa."

let poWyrazie =
    ipsum
        .split { $0 == " " }
        .map { String($0) }


var wielkieWyrazy = poWyrazie.filter({ (wyraz: String) -> Bool in
    return wyraz.first == wyraz.uppercased().first
})

print(wielkieWyrazy)

//: Jeżeli blok jest ostatnim parametrem do funkcji to może sotać napisany za nawiasami ()

wielkieWyrazy = poWyrazie.filter() { (wyraz: String) -> Bool in
    return wyraz.first == wyraz.uppercased().first
}

print(wielkieWyrazy)

//: Dodatkowo jeżeli funkcja nie przyjmuje żadnych wymaganych argumentów to i same nawiasny można pominąć.

wielkieWyrazy = poWyrazie.filter { (wyraz: String) -> Bool in
    return wyraz.first == wyraz.uppercased().first
}

print(wielkieWyrazy)

//: Jeżeli kompilator jest w stanie wywnioskować typ przekazywanych agumentów to go również można pominąć.

wielkieWyrazy = poWyrazie.filter() { wyraz -> Bool in
    return wyraz.first == wyraz.uppercased().first

}

print(wielkieWyrazy)

//: Idąc dalej jeżeli kompilator jest w stanie wywnioskować zwracany typ z bloku to go też możemy pominąć.

wielkieWyrazy = poWyrazie.filter() { wyraz in
    return wyraz.first == wyraz.uppercased().first

}

print(wielkieWyrazy)

//: Jeżeli blok zawiera tylko jedną linijkę kodu to można pominąć słowo kluczowe _return_ .

wielkieWyrazy = poWyrazie.filter() { wyraz in
    wyraz.first == wyraz.uppercased().first
}

print(wielkieWyrazy)

//: Jeżeli nie chcemy to nie musimy nawet nazywać parametrów w bloku.

wielkieWyrazy = poWyrazie.filter() {
    $0.first == $0.uppercased().first
}

print("\(wielkieWyrazy)")

//: Jeżeli funkcja nie przyjmuje innych argumentów lub mają one domyślne wartości to można się też pozbyć nawiasów () za nazwą funkcji.

wielkieWyrazy = poWyrazie.filter {
    $0.first == $0.uppercased().first
}

print("\(wielkieWyrazy)" + "\n")

//: ## Użycie Bloku Inline
//: Bloków można użyc do przypisania wartości do zmiennej np.

let losowyWyraz: String = {
    let losowyIndex = Int(arc4random_uniform(UInt32(wielkieWyrazy.count)))
    return wielkieWyrazy[losowyIndex]
}() // <-- ()

//: Przypisanie Bloku do Zmiennej

let krasomowca = { print("Można pić bez obawień") }
type(of: krasomowca)
krasomowca()

let losowyWielkiWyraz: () -> String = {
    let losowyIndex = Int(arc4random_uniform(UInt32(wielkieWyrazy.count)))
    return wielkieWyrazy[losowyIndex]
}

print(losowyWielkiWyraz())

//: Inny przykład

let t1 = 40
let t2 = 2

func dodajDwieLiczby(_ liczba1: Int, liczba2: Int) -> Int {
    return liczba1 + liczba2
}
let sumaLiczb = dodajDwieLiczby(t1, liczba2: t2)

let dodawacz: (_ a: Int, _ b: Int) -> Int = { (liczba1: Int, liczba2: Int) -> Int in
    liczba1 + liczba2
}

type(of: dodajDwieLiczby) == type(of: dodawacz)

dodawacz(t1, t2) == sumaLiczb

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
