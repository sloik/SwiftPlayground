//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Obsługa Błędów

import Foundation

let error1 =  Bool.random()
let error2 =  Bool.random()

//: Klasy, struktury oraz enumeracje mogą być użyte do stworzenia _błędu_ .

enum SomethingWentWrong: Error {
    case badLuck
    case ups(code: Int, function: String, line: Int)
}

func mayExplode() throws {
    defer {
        print("🤔 Wystąpił babol1: \(error1)\t\tWystąpił babol2: \(error2)")
    }


    guard error1 == false else {
        throw SomethingWentWrong.badLuck
    }

    guard error2 == false else {
        throw SomethingWentWrong.ups(code: 69, function: #function, line: #line)
    }

    print("😎 jednak nie wybuchło")
}

do {

    try mayExplode()
    print("🍻 wszystko działa")

} catch SomethingWentWrong.badLuck {

    print("💥 jak pech to pech")

} catch let SomethingWentWrong.ups(kod, funkcja, linijka) where kod > 42 {

    print("💥 Cos wybuchło w funkcji: \"\(funkcja)\" w linijce: \"\(linijka)\"")

} catch {
    
//: nie jawnie jest towrzona lokalna zmienna __error__ do której możemy się odwoływać.
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

//: Funkcja która może "rzucić błąd" również może zwracać wartość.

func meaningOfLifeThatMayExplode() throws -> Int {
    throw SomethingWentWrong.badLuck
    return 42
}

var whatsTheMeaningOfLife = try? meaningOfLifeThatMayExplode()
type(of: whatsTheMeaningOfLife)
whatsTheMeaningOfLife

whatsTheMeaningOfLife = try! meaningOfLifeThatMayExplode()
type(of: whatsTheMeaningOfLife)
whatsTheMeaningOfLife

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
