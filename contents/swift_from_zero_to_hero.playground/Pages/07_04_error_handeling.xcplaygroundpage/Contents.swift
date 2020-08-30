//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Obsługa Błędów

import Foundation

//: Klasy, struktury oraz enumeracje mogą być użyte do stworzenia _błędu_. Aby to zrobić musimy je oznaczyć jako _konformujące do protokołu `Error`_. Jest to _marker protocol_ (nie zawiera żadnych wymagań).

enum SomethingWentWrong: Error {
    case badLuck
    case ups(code: Int, function: StaticString = #function, line: Int = #line)
}

/*:
 W tym wypadku skorzystamy z enumeracji. Można o nich myśleć jak o z góry ustalonym zbiorze wartości. Świetnymi kandydatami do enumeracji są np. dni tygodnia, wartości oczek na kostce.
 
 Czas napisać funkcję, która będzie mogła _rzucić_ błąd. W tym celu musimy po jej typie dodać słowo kluczowe `throws`.
 */

func mayExplode() throws {
    let error1 =  Bool.random()
    let error2 =  Bool.random()
    defer {
        print("🤔 Wystąpił babol1: \(error1)\t\tWystąpił babol2: \(error2)")
    }


    guard error1 == false else {
        throw SomethingWentWrong.badLuck
    }

    guard error2 == false else {
        throw SomethingWentWrong.ups(code: 69)
    }

    print("😎 jednak nie wybuchło")
}

/*:
 Swift stara się być bezpiecznym językiem. To bezpieczeństwo polega na tym, że wymusi obsłużenie _dziwnych_ sytuacji. Rzucanie błędem jest taką sytuacją i wymaga w miejscu wywołania rzucającej funkcji wpisania słowa kluczowego `try`. Dodatkowo całość musi być owinięta w blok `do catch`, który służy do _przechwytywania_ tak powstałych błędów i ich obsłużenia.
 
 Co więcej bloków `catch` może być więcej. Każdy wyspecjalizowany do konkretnego typu błędu. Na samym końcu można dać blok `catch` bez żadnych argumentów. Zostanie on wywołany w sytuacji, gdy żaden inny blok nie przechwycił tak rzuconego błędu.
 
 W pewnym sensie jest to wariacja na temat `switch` gdzie od góry do dołu są dopasowywane wyjątki i gdy żaden nie pasuje to jest wywołana sekcja `default`.
 
 Zobaczmy to w akcji:
 */

do {

    try mayExplode()
    print("🍻 wszystko działa")

} catch SomethingWentWrong.badLuck {

    print("💥 jak pech to pech")

} catch let SomethingWentWrong.ups(kod, funkcja, linijka) where kod > 42 {

    print("💥 Cos wybuchło w funkcji: \"\(funkcja)\" w linijce: \"\(linijka)\"")

} catch {
    
//: nie jawnie jest tworzona lokalna zmienna __error__ do której możemy się odwoływać.
    type(of: error)
    print("💥 handlujemy error: \(error)")
}

//: Jeżeli jakaś funkcja wywołuje funkcję, która może rzucić błąd to mamy dwie opcje:
//: * funkcja wołająca łapie błąd "handluje"
//: * i/lub rzuca błąd dalej

func functionCallingMayExplode() {
    do {
    try mayExplode()
    } catch {
        print("😱 wołająca ohandlowała")
    }
}

print("\n.   .   .   .   .   .   .   . \n")

functionCallingMayExplode()

//: Teraz fragment wywołujący tą funkcje musi albo "ohandlować" błąd albo sam "rzucać" go dalej.
func functionThatItSelfMayExplode() throws {
        try mayExplode()
}

print("\n-   -   -   -   -   -   -   - \n")
do {
    try functionThatItSelfMayExplode()
} catch {
    print("💥 handlujemy error: \(error)")
}

/*:
 Funkcja która może "rzucić błąd" również może zwracać wartość. Niestety na dzień dzisiejszy nie mamy jak powiedzieć jakiego rodzaju błędy funkcja może rzucić. To co możemy zrobić to opisać je w części dokumentacji funkcji.
 */

func meaningOfLifeThatMayExplode() throws -> Int {
    throw SomethingWentWrong.badLuck
    return 42
}

/*:
 Jeżeli nie chcemy bawić się w `do catch` to można użyć słowa kluczowego `try` razem ze znakiem zapytania. To sprawi, że będziemy musieli obsłużyć w kodzie wartość opcjonalną.
 */
var whatsTheMeaningOfLife = try? meaningOfLifeThatMayExplode()
type(of: whatsTheMeaningOfLife)
whatsTheMeaningOfLife

/*:
 Gdy mamy pewność (damy Szwagru uciąć), że wszystko jest ok i funkcja nie rzuci w nas żadnym wyjątkiem to możemy skorzystać z wersji `try` udekorowanej wykrzyknikiem. Jednak należy pamiętać, że jeżeli coś pójdzie nie tak to program się wyłoży i dalsze linijki kodu nie będą wykonane.
 */
whatsTheMeaningOfLife = try! meaningOfLifeThatMayExplode()
type(of: whatsTheMeaningOfLife)
whatsTheMeaningOfLife

print("🐲 this line will never be printed")

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
