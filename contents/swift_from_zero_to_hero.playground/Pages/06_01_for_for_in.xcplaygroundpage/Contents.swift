//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## For "i" For In / Break Continue / Do
/*:
 
 * [🇵🇱 Swift od zera do bohatera! Instrukcje Sterujące - Pętle - For In](https://www.youtube.com/watch?v=kV2yvP2gVj8&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=18)
 * [🇵🇱 Swift od zera do bohatera! Pętla - For In - Funkcja Stride - Instrukcje Break oraz Continue](https://www.youtube.com/watch?v=NF2Be3KwVDE&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=19)
 * [🇵🇱 Swift od zera do bohatera! For In - Przerywania Zagnieżdżonych Pętli - Repeat While i Do Block](https://www.youtube.com/watch?v=_wmHcruq9lM&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=20)
 
 
Swift daje kilka **instrukcji**, które służą do kontrolowania jaki kod zostanie wykonany (kolejne instrukcje jakie mają być wykonane). Zaczniemy przygodę od **pętli**. Są to takie instrukcje, które pozwalają wykonywać kod _ileś razy_ i/lub tak długo jak _jakiś warunek jest spełniony_ (predykat jest prawdziwy).
 
 Wiele rzeczy można zaimplementować jako takie pętle. Dwa proste przykłady to gdy pracujemy z kolekcją (np. Array) elementów i z każdym chcemy coś zrobić. Pętle się super do tego nadają.
 
 Drugi przykład to gdy nie wiemy kiedy coś się ma zakończyć i chcemy aby działało tak długo jak jakiś warunek jest spełniony. Przykładami takich aplikacji są gry (tzw. game loop) lub wszelkiego rodzaju serwery, które czekają na połączenie klientów.
 
 ### Kilka przykładów
 */

let tablica = ["💩", "😎", "🍻"]
let slownik = ["💩" : "kupka", "😎" : "luzak", "🍻" : "browar"]
let zakres  = -1...1
let liczby  = [1, 2, 3];

//: ### For
//: Od Swift 3.0 `for` taki jak w `C` nie istnieje. To było szybkie ;)

/*:
 ### For In
 
 Bardzo fajna instrukcja, która _za nas_ wyciąga element z kolekcji tak abyśmy mogli z nim swobodnie pracować.
 */

run("🦠 for in") {
    
    print("Iteracja po słowniku:")
    for i in slownik {
        print("    typ:", type(of: i))
        print("element:", i)
    }
    
/*:
 Pod jednym symbolem _i_ dla słownika mamy tuplet zawierający klucz oraz wartość z tego słownika.
    Możemy rozbić to bardziej:
*/
    
    print("\nIteracja po słowniku rozbicie :")
    for (key, value) in slownik {
        print("  key:", key)
        print("value:", value)
    }
    
//: Zobaczmy co dostaniemy iterując po pozostałych kolekcjach
    for element in tablica {
        print("tablica:", element, type(of: element))
    }
    
    __
    
    for element in zakres {
        print("zakres:", element, type(of: element))
    }
    
    __
    
    for element in liczby {
        print("liczby:", element, type(of: element))
    }
}
/*:
 Jak widać mamy bardzo podobny kod dla każdej z tych kolekcji. I to jest bardzo dobre ponieważ używamy ponownie tego co umiemy dla jednego typy przy pracy z drugim. Co więcej od tej instrukcji dostajemy jeden element z którym możemy pracować.
 
 ---
 
 Używając instrukcji pętli nie zawsze interesuje nas element. Czasem chcemy po prostu wykonać coś ileś razy. Więc aby go zignorować, możemy to zrobić tak:
 */

run("🏵 for ignorowanie elementu") {
    for _ in 0..<3 {
        print("Niebo w ziemi. -- Wiesław Wszywka");
    }
}

/*:
 Jeżeli potrzebujemy większej kontroli nad tym jak jest generowany _krok_ w pętli to możemy do tego użyć funkcji _stride_. Przyjmuje ona 3 parametry, punkt startowy, końcowy oraz co ile do przodu się poruszamy.
 */

run("🎯 stride") {
    for i in stride(from: 0, to: 9, by: 3) {
        print(#line, i)
    }
    
    for i in stride(from: 0, through: 9, by: 3) {
        print(#line, i)
    }
    
    for i in stride(from: 3, to: 0, by: -1) {
        print(#line, i)
    }
}


/*:
 Co nie jest oczywiste ale text czyli stringi to też są kolekcje. A to znaczy, że możemy po nich iterować!
 */

run("🧊 iteracja po stringach") {
    for literka in "Niebo w ziemi" {
        print(#line, literka, type(of: literka))
    }

    /*:
     W wypadku kiedy interesuje nas też który jest to element możemy zapisać to tak:
     */
    
    for literka in "Niebo w ziemi".enumerated() {
        print(#line, literka, type(of: literka))
    }
    
    /*:
     lub od razu to rozbijając na części jak przy słowniku:
     */
    for (offset, element) in "Niebo w ziemi".enumerated() {
        print(#line, offset, type(of: offset), element, type(of: element))
    }
}

/*:
 Ta składnia pozwala nam dodatkowo określać warunki kiedy kod wewnątrz ma się wykonać. Powiedzmy, że dostajemy zakres od -3 do 3 ale chcemy aby kod się wykonał tylko dla liczb większych od 0. Moglibyśmy zrobić to tak:
 */

run("🥮 no where") {
    for i in -3...3 {
        if i > 0 {
            print(#line, i)
        }
    }
}

/*:
 Predykat/warunek z _if_ możemy przesunąć do samej instruk _for in_ za pomocą instrukcji _where_.
 */

run("🍣 where") {
    for i in -3...3 where i > 0 {
            print(#line, i)
    }
}

/*:
 
 ## Break Continue
 
 Mając już pętle i po niej iterując może zajść potrzeba aby zakończyć ją wcześniej lub przeskoczyć jedną iterację i od razu przejść do następnej bez wykonywania ciała pętli.
 
 Szkolnymi przykładami może być wyszukiwanie elementu w kolekcji. Gdy już go znajdziemy nie ma potrzeby przechodzić po reszcie elementów (tu chcemy zakończyć wcześniej). Natomiast gdy mamy kolekcję liczb i chcemy wypisać tylko nie parzyste to chcemy _przeskoczyć_ do następnej iteracji.
 
 Rzućmy na to okiem:
 */

run("🥩 break i continue") {
    for wartosc in 0...10 {
        if wartosc > 2 && wartosc < 8 {
            print(#line, "warunek wyjscia zostal spelniony")
            break
        }

        print(#line, "[break] Ostatnia Wartosc: \(wartosc)")
    }
    
    __
    
    for wartosc in 0...10 {
        if wartosc % 2 == 0 {
            print(#line, "pomijam liczby parzyste")
            continue
        }

        print(#line, "[continue] Ostatnia Wartosc: \(wartosc)")
    }
}

/*:
 Jak widać _break_ zakończył całkowicie przechodzenie po pętli. Natomiast _continue_ przeskoczyło tylko jedną iteracje.
 
 Co jest ważne to obie instrukcje kończą pętle w której się znajdują. Co jednak w przypadku gdy jesteśmy w zagnieżdżonych pętlach i chcemy zakończyć obie, trzy lub więcej? Moglibyśmy mieć jakieś zmienne, które by były ustawiane ale przy większym zagnieżdżeniu taki kod stałby się bardzo nie czytelny i trudny do zmiany.
 
 ## Labelki Na Pętlach
 
 Możemy instrukcje oznaczać/tagować labelkami. Dzięki temu nawet z bardzo zagnieżdżonej pętli jesteśmy w stanie wyjść lub pominąć jej iteracje:
 */

run("🍀 zagnieżdżone pętle") {
    petlaSekcji:
        for sekcja in 0...100_000_000 {
            
            petlaWierszy:
                for wiersz in 0...10 {
                    print(#line, "sekcja: \(sekcja) wiersz: \(wiersz)")
                    
                    if wiersz > 0 {
                        print(#line, "z petli wierszy przerywam petle sekcji")
                        break petlaSekcji
                    }
            }
    }
}


/*:
 ### [do](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Statements.html#//apple_ref/doc/uid/TP40014097-CH33-ID533) {}
 
  Wprowadza nowy "zakres" (scope) i może opcjonalnie zawierać blok __catch__.
 
 ___
 
 Zaczynając od końca to blok __catch__ służy do obsługiwania wyjątków. Nie mówiliśmy jeszcze nic na temat wyjątków i obsługi błędów. Natomiast powiedzmy na ten moment, że to jest taki blok kodu, który zostanie wykonany gdy się wydarzy coś niespodziewanego.
 
 __Scope__ z drugiej strony określa nam widoczność i (może też) czas _życia_ oiketów/wartości z jakimi pracujemy. Uwaga bo tutaj to pojęcie stosuje bardzo _nie technicznie_.
  
 Co jest _mylące_ to w innych językach występuje pętla __do while__. Jest też ona obecna w Swift ale się nazywa __repeat while__.

 */


run("🐠 scope") {
    let widocznaWszedzie = 42
    
    do {
        let blok1 = 69
        
        do {
            let blok2 = 4269
            
            print(#line, "mam dostep do:", widocznaWszedzie, blok1, blok2)
        }
        
        do {
            let blok1 = 6969
            let blok2 = 4242
            
            print(#line, "mam dostep do:", widocznaWszedzie, blok1, blok2)
        }
        
        print(#line, "mam dostep do:", widocznaWszedzie, blok1)
    }
    
    print(#line, "mam dostep do:", widocznaWszedzie)
}

//: ## reapeat while

var licznik = 0

repeat {

    print(#line, licznik)
    licznik += 1

} while licznik < 10

/*:
 Jak witać to samo osiągniemy używając pętli _for in_ i co więcej nie musimy sami pamietać o inkrementacji zmiennej odpowiedzialnej za przerwanie pętli. To kiedy ta instrukcja może się przydać to gdy chcemy aby ciało instrukcji wykonało się chociaż raz.
 */

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
