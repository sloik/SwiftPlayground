//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Bloki / Lambdy / Funkcje Anonimowe

import Foundation

//: Funkcje w Swift to tak naprawdę specjalne przypadki bloków. Same w sobie są _blokiem_ kodu który możemy użyć bezpośrednio, przekazać jako parametr lub przechować w zmiennej aby wywołać w bardziej odpowiednim czasie (lub dla czytelności kodu). 

let ipsum = "Drogi Marszałku, Wysoka Izbo. PKB rośnie. Różnorakie i określenia modelu rozwoju. W związku z powodu kolejnych kroków w kształtowaniu odpowiednich warunków administracyjno-finansowych. Już nie trzeba udowadniać, ponieważ zakup nowego sprzętu pomaga w tym zakresie zabezpiecza udział szerokiej grupie w restrukturyzacji przedsiębiorstwa."

let byWord =
    ipsum
        .split { $0 == " " }
        .map { String($0) }


var uppercasedWords = byWord.filter({ (word: String) -> Bool in
    return word.first == word.uppercased().first
})

print(uppercasedWords)

//: Jeżeli blok jest ostatnim parametrem do funkcji to może sotać napisany za nawiasami ()

uppercasedWords = byWord.filter() { (word: String) -> Bool in
    return word.first == word.uppercased().first
}

print(uppercasedWords)

//: Dodatkowo jeżeli funkcja nie przyjmuje żadnych wymaganych argumentów to i same nawiasny można pominąć.

uppercasedWords = byWord.filter { (word: String) -> Bool in
    return word.first == word.uppercased().first
}

print(uppercasedWords)

//: Jeżeli kompilator jest w stanie wywnioskować typ przekazywanych agumentów to go również można pominąć.

uppercasedWords = byWord.filter() { word -> Bool in
    return word.first == word.uppercased().first

}

print(uppercasedWords)

//: Idąc dalej jeżeli kompilator jest w stanie wywnioskować zwracany typ z bloku to go też możemy pominąć.

uppercasedWords = byWord.filter() { word in
    return word.first == word.uppercased().first

}

print(uppercasedWords)

//: Jeżeli blok zawiera tylko jedną linijkę kodu to można pominąć słowo kluczowe _return_ .

uppercasedWords = byWord.filter() { word in
    word.first == word.uppercased().first
}

print(uppercasedWords)

//: Jeżeli nie chcemy to nie musimy nawet nazywać parametrów w bloku.

uppercasedWords = byWord.filter() {
    $0.first == $0.uppercased().first
}

print("\(uppercasedWords)")

//: Jeżeli funkcja nie przyjmuje innych argumentów lub mają one domyślne wartości to można się też pozbyć nawiasów () za nazwą funkcji.

uppercasedWords = byWord.filter {
    $0.first == $0.uppercased().first
}

print("\(uppercasedWords)" + "\n")

//: ## Użycie Bloku Inline
//: Bloków można użyc do przypisania wartości do zmiennej np.

let randomWord: String = {
    byWord.randomElement()!
}() // <-- ()

//: Przypisanie Bloku do Zmiennej

let prettyTalker = { print("Można pić bez obawień") }
type(of: prettyTalker)
prettyTalker()

let randomUppercasedWords: () -> String = {
    uppercasedWords.randomElement()!
}

print(randomUppercasedWords())

//: Inny przykład

let t1 = 40
let t2 = 2

func addTwoNumbers(_ number1: Int, number2: Int) -> Int {
    return number1 + number2
}
let sumOfNumbers = addTwoNumbers(t1, number2: t2)

let adder: (_ a: Int, _ b: Int) -> Int = { (number1: Int, number2: Int) -> Int in
    number1 + number2
}

type(of: addTwoNumbers) == type(of: adder)

adder(t1, t2) == sumOfNumbers

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
