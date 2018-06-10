//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Protocols](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html)
/*:
Najłatwiej myśleć o protokołach jak o kontrakcie zawierającym wymagania, które adoptujący typ (struktura/klasa/typ prosty) "obiecuje" spełnić. Jeżeli taka sytuacja nastąpi to mówimy, że dany tym implementuje dany protokół.

W definicji protokolu mogą się znajdować metody jak rownież i właściwości oraz, co jest unikalne dla Swift-a, domyślne implementacje tych metod. Dodatkowo protokoły mogą dziedziczyć po sobie.
*/

import Foundation

//: ## Definiowanie Protokołu

protocol Pogodynka {
    var wilgotnosc:  Int { get }
    var temperatura: Int { get set } // let 💥

    func statusPogody()
}

//: ## Dziedziczenie Protokołów
//: Podajemy listę protokołów po ":" oddzielając je przecinkami. Dodatkowo jeżei chcemy aby aby protkół mogły implementować tylko klasy jako pierwsze piszemy słowo kluczowe **class**.

protocol PogodynkaTV: class, Pogodynka {
    var imie: String { get }
    var wiek: Int? { get }

    init(imiePogodynki: String, wiekPogodynki: Int?) // 💡

//: Chwilowo tylko klasy dziedziczące z NSObject (lub po klasie, która dziedziczy z NSObject) mogą implementować opcjonalne metody.
//    optional func opcjonalnaMetoda() -> Void // 💥 "'optional' can only be applied to members of an @objc protocol"
}

protocol Liczacy {
    static var licznikInstancji: Int { get }

    static func liczbaInstancji() -> Int
}


/*:
💥 "non-class type 'Nydyrydy' cannot conform to class protocol 'PogodynkaTV'"
*/
//struct Nydyrydy: PogodynkaTV {
//    var wilgotnosc: Int
//    var temperatura: Int
//    var imie: String
//    var wiek: Int?
//    func statusPogody() {}
//
//    init(imiePogodynki: String, wiekPogodynki: Int? = nil) {
//        imie = imiePogodynki
//        wiek = wiekPogodynki
//    }
//}

//: ## Implementowanie Prtokołu

class Implementuje: PogodynkaTV, Liczacy {
    // PogodynkaTV
    var imie: String
    var wiek: Int?

    // Pogodynka
    fileprivate(set) var wilgotnosc: Int = 69 // protokol wymaga tylko gettera
    var temperatura: Int = 24

    func statusPogody() {
        print("Wilgotnosc: \(wilgotnosc)\tTemperatura: \(temperatura)")
    }

    // Liczacy
    static var licznikInstancji: Int = 0

    // Pozostale Metody Typu
    required init(imiePogodynki: String, wiekPogodynki: Int? = nil) {
        imie = imiePogodynki
        wiek = wiekPogodynki

        Implementuje.licznikInstancji += 1
    }

    deinit {
        Implementuje.licznikInstancji -= 1
    }

    func ustawWilgotnosc(_ nowaWilgotnosc: Int) {
        wilgotnosc = nowaWilgotnosc
    }
}

//: ## Domyślna Implementacja
//: Normalnie w przyrodzie raczej występuje zaraz przy definicji protokołu :)

extension Liczacy {
    static func liczbaInstancji() -> Int {
        print("\(Self.licznikInstancji)")
        return Self.licznikInstancji
    }
}

//: ### Przykłady :)

var pogodynka = Implementuje.init(imiePogodynki: "Sandra")
pogodynka.statusPogody()
pogodynka.ustawWilgotnosc(80)
pogodynka.statusPogody()
Implementuje.liczbaInstancji()

do {
    Implementuje.init(imiePogodynki: "Natalia") // 💡 żyje na stosie
    Implementuje.liczbaInstancji()
}

Implementuje.liczbaInstancji()

//: Tablica Obiektów Implementująca Protokoły

class Jakis: Liczacy {
    static var licznikInstancji: Int = 0
}

var implementujace: [Pogodynka & Liczacy] = []
type(of: implementujace)

typealias SamoliczacaSiePogodynka = Pogodynka & Liczacy
let samoliczaca: [SamoliczacaSiePogodynka] = []

type(of: implementujace) == type(of: samoliczaca)

implementujace.append(pogodynka)

let cosiek = Jakis()
Jakis.licznikInstancji

//implementujace.append(cosiek) // 💥

implementujace

//: ## Delikatna Introspekcja
//: Czasami chcemy wiedzieć czy jakiś typ implementuje dany protokół...

Implementuje.self is PogodynkaTV
Implementuje.self is Pogodynka

//: Typ **musi** zadeklarować, że implementuje dany protokół.
pogodynka is PogodynkaTV // 💡 usuń "PogodynkaTV" z definicji klady "Implementuje"
pogodynka is Pogodynka


if let pog = pogodynka as? Pogodynka {
    pog.temperatura
}

//: Typ ktory jest klasa i konforumuje do protokolu
protocol TestowyProtocol {}
class WlasnaKlasa {}
class Podklasa: WlasnaKlasa, TestowyProtocol {}

let klasaImplementujacaProtokol: (WlasnaKlasa & TestowyProtocol) = Podklasa()

let kolekcja: [(WlasnaKlasa & TestowyProtocol)] = [Podklasa(), Podklasa()]

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
