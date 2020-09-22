//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Bloki / Lambdy / Funkcje Anonimowe

import Foundation

/*:
 Funkcje w Swift to tak naprawdę specjalne przypadki bloków. Same w sobie są _blokiem_ kodu który możemy użyć bezpośrednio, przekazać jako parametr lub przechować w zmiennej aby wywołać w bardziej odpowiednim czasie (lub dla czytelności kodu).
 
 > Inna nazwa jaką można spotka to: domknięcia (ang. closure) oraz lambda (λ taka grecka litera). Domknięcie odnosi się do tego jak blok _łapie_ (domyka) jakąś zmienną. Natomiast lambda to referencja do rachunku lambda wprowadzonego między innymi przez Alonzo Churcha (_Church encoding_).
 */

let ipsum = "Drogi Marszałku, Wysoka Izbo. PKB rośnie. Różnorakie i określenia modelu rozwoju. W związku z powodu kolejnych kroków w kształtowaniu odpowiednich warunków administracyjno-finansowych. Już nie trzeba udowadniać, ponieważ zakup nowego sprzętu pomaga w tym zakresie zabezpiecza udział szerokiej grupie w restrukturyzacji przedsiębiorstwa."

let byWord =
            ipsum
                .split{ $0 == " " }
                .map( String.init )

/*:
 Funkcja `split` oczekuje bloku/closure/domknięcia który będzie mówić _kiedy_ dany string ma być podzielony.
 */

run("🐭 by word") {
    print(byWord)
}

/*:
 Pełna składnia przekazania takiego bloku jako argumentu wygląda tak:
 */

var uppercasedWords = byWord.filter({ (word: String) -> Bool in
    return word.first == word.uppercased().first
})

/*:
 Jest to troszeczkę hałaśliwe. Dużo nawiasów, paciorków, słów kluczowych. Zobaczmy wynik działania tej operacji i dalej zobaczymy kiedy można pominąć pewne fragmenty.
 */

print(uppercasedWords)


//: Jeżeli blok jest ostatnim parametrem do funkcji to może zostać napisany za nawiasami ()

uppercasedWords = byWord.filter() { (word: String) -> Bool in
    return word.first == word.uppercased().first
}

print(uppercasedWords)

//: Dodatkowo jeżeli funkcja nie przyjmuje żadnych wymaganych argumentów to i same nawiasy można pominąć.

uppercasedWords = byWord.filter { (word: String) -> Bool in
    return word.first == word.uppercased().first
}

print(uppercasedWords)

//: Jeżeli kompilator jest w stanie wywnioskować typ przekazywanych argumentów to go również można pominąć.

uppercasedWords = byWord.filter { word -> Bool in
    return word.first == word.uppercased().first

}

print(uppercasedWords)

//: Idąc dalej jeżeli kompilator jest w stanie wywnioskować zwracany typ z bloku to go też możemy pominąć.

uppercasedWords = byWord.filter { word in
    return word.first == word.uppercased().first

}

print(uppercasedWords)

//: Jeżeli blok zawiera tylko jedną linijkę kodu to można pominąć słowo kluczowe _return_.

uppercasedWords = byWord.filter { word in
    word.first == word.uppercased().first
}

print(uppercasedWords)

/*:
 Jeżeli nie chcemy to nie musimy nawet nazywać parametrów w bloku. Odwołujemy się do nich przy pomocy notacji z `$`. Do pierwszego argumentu można odwołać się korzystając z `$0`, do drugiego `$1` itd.
 */

uppercasedWords = byWord.filter {
    $0.first == $0.uppercased().first
}

print("\(uppercasedWords)")

//: ## Użycie Bloku Inline
//: Bloków można użyć do przypisania wartości początkowej do zmiennej lub stałej np.

let randomWord: String = {
    byWord.randomElement()!
}() // <-- ()

//: Przypisanie Bloku do Zmiennej

var prettyTalker = { print("Można pić bez obawień") }
type(of: prettyTalker)
prettyTalker()

/*:
 `prettyTalker` to zmienna jak każda inna. Ale to co przechowuje to wskazanie/referencje na funkcję. Patrząc na typ funkcji `() -> ()` wiemy, że funkcja nie przyjmuje żadnych argumentów. Oraz, że nie zwraca żadnej wartości.
 
 Technicznie to ostatnie zdanie to nie jest prawda. Ponieważ pusta krotka `()` jest _zawsze_ zwracana (dla funkcji, które jawnie nie zwracają wartości).
 
 Coś na co warto zwrócić uwagę to często funkcje, które nie zwracają żadnej wartości (mające typ: `-> ()` lub `-> Void`) są wywołane po to aby **wykonać jakiś efekt uboczny**. To może być strzał do sieci, zapisanie czegoś w bazie, wypisanie do konsoli etc. Coś co sprawia, że świat zewnętrzny się zmienia. Resztę życia programiści poświęcają na poszukiwanie błędów związanych z niekontrolowanymi efektami ubocznymi.
 
 Poniżej jeszcze jednak funkcja. Tym razem przypisana do stałej o nazwie `randomUppercasedWords`. Jak widać wewnątrz tego bloku kodu mamy dostęp do wszystkich stałych i zmiennych widocznych na tym poziomie w programie. Możemy więc je _domknąć_ w tych nawiasach i od tego momentu trzymać do nich referencje i w dowolnym momencie korzystać.
 */

let randomUppercasedWords: () -> String = {
    uppercasedWords.randomElement()!
}

print(randomUppercasedWords())

//: Inny przykład

let t1 = 40
let t2 = 2

/*:
 Definicja funkcji jak zwykle:
 */
func addTwoNumbers(_ number1: Int, _ number2: Int) -> Int {
    return number1 + number2
}
let sumOfNumbers = addTwoNumbers(t1, t2)

/*:
 To samo możemy zapisać inaczej. Wykorzystując stałą i nadać odpowiednie typy. Warto rzucić okiem gdzie jakie wartości wylądowały.
 */
let adder: (_ a: Int, _ b: Int) -> Int = { (number1: Int, number2: Int) -> Int in
    number1 + number2
}

type(of: addTwoNumbers) == type(of: adder)

/*:
 Wywołanie funkcji w jednym i drugim przypadku jest identyczne. Bez patrzenia w implementację nie można stwierdzić czy coś jest zdefiniowane jako _symbol_ funkcja gdzieś w programie czy jest to stała/zmienna przetrzymująca blok.
 
 Tak na prawdę nie ma to większego znaczenia. Patrzymy na to samo ale pod innym kątem.
 */
adder(t1, t2) == addTwoNumbers(t1, t2)

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
