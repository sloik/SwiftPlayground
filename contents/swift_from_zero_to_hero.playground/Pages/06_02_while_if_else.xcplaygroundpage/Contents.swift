//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## While / Repeat While / If / If Else / If Let / Guard

import Foundation

/*:
 # Wstęp
 
 Zanim poznamy następne instrukcje sterujące to poznamy funkcje do _generowania_ liczb pseudo losowych. Tak na prawdę to jest ich więcej ale jest jedna, która w miarę równomiernie z zakresu _losuje_ liczby.
 */


run("🧂 losowa funkcja") {
    let gornyZakres: UInt32 = 6
    let liczbaLosowan = 30
    
    for _ in 0..<liczbaLosowan {
        let losowaLiczba = arc4random_uniform(gornyZakres)
        
        print(losowaLiczba, terminator: " ")
    }
}

/*:
 O wszystkim co jest widoczne w bloku kodu wyżej już mówiliśmy. Ale dla szybkiego przypomnienia:
 
 * tworzymy stale, które mówią jaka ma być maksymalna wylosowana liczba oraz górną granicę dla pętli
 * wołamy funkcję `arc4random_uniform` przekazując górny zakres **wylosowane liczby będą z zakresu 0..<gornyZakres**
 * wypisujemy wylosowaną liczbę w konsoli
 
 ## Inne Zakresy
 
 Prostymi działaniami arytmetycznymi mogę sprawić, że zakres losowych liczb będzie dowolny a nie tylko od `0` ale w zdefiniowanym zakresie. Co prawda musimy go _ręcznie_ przesunąć. Zachęcam do pobawienia się parametrami i zobaczenia jak działa.
 */

run("🍷 losowa liczba z przedziału \"od do\"") {
    let min: UInt32 = 1
    let max: UInt32 = 6
        
    for _ in 0..<30 {
        
        // tu jest gęste:
        let losowaLiczba = arc4random_uniform(max - min + 1) + min
        
        print(losowaLiczba, terminator: " ")
    }
}

/*:
Uzbrojeni w wiedzę jak możemy _generować_ losowe liczby możemy przejść do właściwego tematu.
 
# While

Instrukcja _while_ wykonuje blok kodu do momentu aż warunek przestanie być prawdziwy. To znaczy, że jeżeli na samym początku nie jest prawdziwy to blok kodu nie wykona się ani razu.
 
 Będziemy losować liczby z zakresu od 1 do 6. Pętla będzie wykonywana tak długo jak nie wylosowane zostaną dwie _1_. Za każdym razem gdy się wykona wypiszemy `.`.
 */

run("🌶 dwie jedynki") {
    while arc4random_uniform(6) + 1 != 1 || arc4random_uniform(6) + 1 != 1 {
        print(".", terminator: "")
    }
}

/*:
# Repeat-While

 O tej instrukcji również wspominaliśmy już wcześniej. Teraz jednak postaramy się za jej pomocą robić coś użytecznego. W przeciwieństwie do instrukcji `while` instrukcja `repeat while` wykona się chociaż raz. A coś takiego możemy wykorzystać do modelowania gry w kości 🦴.
 */

let kosci: [UInt32: String] = [1: "⚀", 2: "⚁", 3: "⚂", 4: "⚃", 5: "⚄", 6: "⚅"]

/*:
 
 Przy pomocy słownika tworzymy UI. Kluczem jest wylosowana liczba a wartością String, który zostanie wypisany w konsoli. W grze w kości wylosowanie `⚀ ⚀` kończy się przegraną dla gracza.
 
 */

run("🎲 gra w kości") {
    var a: UInt32 = 0
    var b: UInt32 = 0

    repeat {
        a = arc4random_uniform(6) + 1
        b = arc4random_uniform(6) + 1

        print(kosci[a]!, kosci[b]!, separator: "", terminator: " ")
    } while a != 1 || b != 1

    print("\nOstatnie:", kosci[a]!, kosci[b]!)
}

/*:
 Pętla będzie się wykonywać tak długo aż nie nastąpi przegrana.
 
 ___
 
# If - If Else
 */


let wynikTestu = Int(arc4random_uniform(50) + 50)

if wynikTestu >= 80 {

    if wynikTestu < 85 {
        "dobra robota"
    } else if wynikTestu < 90 {
        "wysmienicie"
    } else if wynikTestu < 95 {
        "niesamowite"
    }
    else {
        "wybitnie!"
    }
} else {
    "jednak nie zdales"
}

/*:
 # if #available
 
 * [#available](https://www.hackingwithswift.com/new-syntax-swift-2-availability-checking)
 * [Big Nerd Ranch](https://www.bignerdranch.com/blog/hi-im-available/)
 
 Istnieje takie zjawisko jak `fragmentacja`. Na iOS nie jest tak uciążliwa jak na innych platformach ale sprowadza się do tego, że nowych rzeczy nie możemy używać na starych systemach. Wystarczy, że mamy aplikację która jest wspierana do kilku wersji systemu wstecz.
 
 Język daje instrukcje `if #available`, która działa jak `if else` ale pozwala określić z jakich API korzystamy.
 */

if #available(iOS 9, OSX 10.0, watchOS 2.0, *) {
    "Można użyć API"
} else {
    "Nie można użyć API"
}

/*:

 # if let oraz __optional binding__

 Dzięki __optional binding__ możemy sprawdzić czy jakaś opcjonalna zmienna ma wartość (nie jest nil) i ją "odwinąć".
 
 */

var bycMozeCytat: String?
var zPewnosciaCytat: String? = "Można pić bez obawień."

if let bycMozeCytat = bycMozeCytat { // shadowing
    bycMozeCytat
} else {
    "jednak nil"
}

if let _ = zPewnosciaCytat {
    "😎"
}

//: Im więcej tym weselej ;)

var imie    :String? = "Wiesław"
var nazwisko:String? = "Wszywka"

if let imie = imie, let nazwisko = nazwisko {
    imie + " " + nazwisko.uppercased()
}

imie = nil
nazwisko = nil

if let imie = imie, let nazwisko = nazwisko {
    imie + " " + nazwisko
} else {
    "czegoś zabrakło"
}

/*:
 
 # Guard
 
 W działaniu bardzo podobne do __if__. Z tą różnicą, że kod w klamerkach zostanie wykonany jeżeli wynik wyrażenia guard == false. Dodatkowo ostatnim wyrażeniem musi zmieniać ścieżkę wykonania programu.
 */

for i in 0...100 {
    guard  i >= 50 else {
        continue
    }
    guard i <= 55 else {
        break
    }

    i
}

func przyjmujeOptionala(_ bycMozeTekst:String?) {
    guard let naPewnoTekst = bycMozeTekst else {
        "nie bylo tekstu :("
        return
    }

    naPewnoTekst // stala z guard jest dalej dostepna
}

przyjmujeOptionala(nil)
przyjmujeOptionala("Niebo w ziemi")

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
