//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Currying / Rozwijanie Funkcji

import Foundation

//: Rozwijanie Funkcji to technika przy użyciu której jedna metoda zwraca inna ale z mniejszą ilością parametrów. Z czego ta "wewnętrzna metoda" ma dostęp do wszystkich wcześniej podanych.


func dodajProduktZwyczajie(_ produkt: String, cena: Double) -> ((Int) -> String) {

    func znizka(_ iloscSztuk: Int) -> String {
        let przyznanaZnizka: Double

        switch iloscSztuk {
        case ...10:
            przyznanaZnizka = 1.0
        case 11...20:
            przyznanaZnizka = 0.9
        default:
            przyznanaZnizka = 0.8
        }

        return String(format: "Kupujesz \(iloscSztuk) razy \"\(produkt)\" każdy po cenie %.2f co daje łaćznie: %.2f", cena * przyznanaZnizka, cena * przyznanaZnizka * Double(iloscSztuk))
    }

    return znizka
}

let produktDoKupienia = dodajProduktZwyczajie("Złote Galoty", cena: 100)
print(produktDoKupienia(5))


func dodajZwiniety(_ produkt: String, cena: Double) -> ((Int) -> String) {
    return { (iloscSztuk: Int) -> String in

        let przyznanaZnizka: Double

        switch iloscSztuk {
        case ...10:
            przyznanaZnizka = 1.0
        case 11...20:
            przyznanaZnizka = 0.9
        default:
            przyznanaZnizka = 0.8
        }

        return String(format: "Kupujesz \(iloscSztuk) razy \"\(produkt)\" każdy po cenie %.2f co daje łaćznie: %.2f", cena * przyznanaZnizka, cena * przyznanaZnizka * Double(iloscSztuk))
    }
}

let dodanyZwiniety = dodajZwiniety("Brązowe Galoty", cena: 100)
print(dodanyZwiniety(5))


//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
