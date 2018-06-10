//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Obsługa Błędów

import Foundation

let wystapilBabol1 =  arc4random_uniform(2) == 1
let wystapilBabol2 =  arc4random_uniform(2) == 1

//: Klasy, struktury oraz enumeracje mogą być użyte do stworzenia _błędu_ .

enum CosWybuchlo: Error {
    case mialesPecha
    case zwarcie(kod: Int, nazwaFunkcji: String, linijka: Int)
}

func mozeWybuchnac() throws {
    defer {
        print("🤔 Wystapil babol1: \(wystapilBabol1)\t\tWystapil babol2: \(wystapilBabol2)")
    }


    guard wystapilBabol1 == false else {
        throw CosWybuchlo.mialesPecha
    }

    guard wystapilBabol2 == false else {
        throw CosWybuchlo.zwarcie(kod: 69, nazwaFunkcji: #function, linijka: #line)
    }

    print("😎 jednak nie wybuchło")
}

do {

    try mozeWybuchnac()
    print("🍻 wszystko działa")

} catch CosWybuchlo.mialesPecha {

    print("💥 jak pech to pech")

} catch let CosWybuchlo.zwarcie(kod, funkcja, linijka) where kod > 42 {

    print("💥 Cos wybuchło w funkcji: \"\(funkcja)\" w linijce: \"\(linijka)\"")

} catch {
    
//: nie jawnie jest towrzona lokalna zmienna __error__ do której możemy się odwoływać.
    type(of: error)
    print("💥 handlujemy error: \(error)")
}

//: Jeżeli jakaś funkcja wywołuje funkcję, która może rzucić błąd to mamy dwie opcje:
//: * funkcja wołająca łapie błąd "handluje"
//: * i/lub rzuca błąd dalej

func wolajacaWybuchajaca() {
    do {
    try mozeWybuchnac()
    } catch {
        print("😱 wołająca ohandlowała")
    }
}

print("\n.   .   .   .   .   .   .   . \n")

wolajacaWybuchajaca()

//: Teraz fragment wywołujący tą funkcje musi albo "ohandlować" błąd albo sam "rzucać" go dalej.
func wolajacaWybuchajacaDalej() throws {
        try mozeWybuchnac()
}

print("\n-   -   -   -   -   -   -   - \n")
do {
    try wolajacaWybuchajacaDalej()
} catch {
    print("💥 handlujemy error: \(error)")
}

//: Funkcja która może "rzucić błąd" również może zwracać wartość.

func sensZyciaKtoryMozeZawiesc() throws -> Int {
//    throw CosWybuchlo.MialesPecha
    return 42
}

var jakiJestSensZycia = try? sensZyciaKtoryMozeZawiesc()
type(of: jakiJestSensZycia)
jakiJestSensZycia

jakiJestSensZycia = try! sensZyciaKtoryMozeZawiesc()
type(of: jakiJestSensZycia)
jakiJestSensZycia

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
