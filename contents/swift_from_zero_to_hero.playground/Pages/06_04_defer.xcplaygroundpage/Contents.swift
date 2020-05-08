//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:>

import Foundation

/*:
 # [Defer](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html#//apple_ref/doc/uid/TP40014097-CH42-ID514)
 
 Programując staramy się aby kod był jak najbliżej domeny problemu jaki rozwiązujemy. Natomiast czasem musimy zejść na ziemię i pamiętać o tym, że jednak kod jest uruchomiony na maszynie. Ta maszyna ma ograniczone zasoby w postaci prądu/baterii, prędkości procesora, RAMu, ilości połączeń do bazy, otwartych plików i czego tam jeszcze. Czasem musimy o tym pamiętać. W przeciwnym wypadku aplikacje przestaną działać.
 
 Ludzie mają tak, że jak widzą ze sobą zgrupowane rzeczy to traktują taką grupę jak jeden obiekt. Jest tak w malarstwie, ale też i w składaniu tekstu. Tak więc odpowiednio grupując instrukcje w kodzie, możemy powiedzieć że coś _traktujemy jako jedną grupę_.
 
 Są też takie API, które wymagają aby po sobie posprzątać. Zamknąć otwarte połączenie lub plik. Do tego wyśmienicie nadaje się właśnie instrukcja `defer`. Tworzy ona blok kodu, który zostanie wywołany po opuszczeniu jakiegoś `scope`u. Czym jest scope rozmawialiśmy opisując instrukcję `do`. Dla uproszczenia teraz powiem, że każdy blok kodu między wąsatymi nawiasami `{ }`. Gdy wykona się ostatnia instrukcja w takich nawiasach program idzie dalej i ten blok kodu został wykonany.
 
 Prosty blok może wyglądać tak:
 */


run("🐂 simple block, no defer") {
    
    print(#line, "before")
    
    do {
        print(#line, "inside")
    }
    
    print(#line, "after")
    
}

/*:
 To demo z `defer`
 */

run("⛄️ simple block with defer") {
    
    print(#line, "before")
    
    do {
        defer {
            print(#line, "defer")
        }
        
        print(#line, "inside")
    }
    
    print(#line, "after")
    
}

/*:
 Analizując linijka po linijce dochodzimy do wniosku, że kod nie wykonał się od góry do dołu. Możemy ten przykład nieco bardziej ubogacić.
 */

run("🍯 richer block with defer") {
    
    print(#line, "before")
    
    do {
        defer {
            print(#line, "defer")
        }
        
        print(#line, "inside")
        
        defer { // <-- extra defer 👀
            print(#line, "defer")
        }
        
        print(#line, "inside")
    }
    
    print(#line, "after")
    
}

/*:
 Warto odnotować, że **blok kodu zdefiniowany jako ostatni został wykonany jako pierwszy**. Jest taka struktura danych, która się nazywa **stos**. I ona ma takie samo zachowanie. Czyli możemy ze stosu (klasyczny przykład z talerzami) z góra zabrać to co ostatnio tam zostało włożone. Teraz nie będziemy zajmować się _stosem_, co więcej w informatyce stos może znaczyć różne rzeczy.
 
 ## Q: jak więc zachowa się wiele instrukcji defer jeden za drugim?
 
 Nic tak nie robi dobrze jak przykład... ale może jeszcze nieco bardziej rozbudowany ;)
 */

run("🐄 defer defer defer") {
    
    do {
        defer {
            defer {
                print(#line, "🍗🦴")
            }
            print(#line, "🍗")
            
            defer {
                print(#line, "🍗🎹")
            }
            
            print(#line, "🍗")
        }
        
        defer {
            print(#line, "🥎")
        }
        
        defer {
            print(#line, "🍷")
        }
        
        print(#line, ".")
        
        defer {
            print(#line, "🎰")
        }
    }
    
}

/*:
 Przy defer dla 🎰 kompilator pokazuje ostrzeżenie, że w momencie gdy defer jest ostatnia instrukcja w bloku to wykona się natychmiast. Pasuje to do modelu stosu. Po prostu po odłożeniu talerza od razu go podnosimy.
 
 Analizując wynik z konsoli widać, że model jest zachowany:
 * linijka z kropką drukuje się pierwsza
 * potem linijka z 🎰 przed czym ostrzega nas kompilator
 * 🍷 gdyż jest "poziom niżej" na stosie niż 🎰 ... czytamy bloki defer od dołu do góry
 * 🥎 to już jest jasne
 
 Teraz najciekawsza część. Chociaż jak spojrzymy na nią zapominając o reszcie to wszystko się zgadza:
 * 2x 🍗 jest wypisany pierwszy ponieważ nie jest w żadnym z bloków _defer_
 * następnie ze stosu spada defer z 🍗🎹
 * i na sam koniec 🍗🦴
 
# Fajne ale po co to komu...
 
 Jak wspominałem komputer ma ograniczone zasoby. Jeżeli nie oddamy nie używanej pamięci to w pewnym momencie się po prostu skończy. Jeżeli nie zamkniemy pliku z którego czytamy to nikt inny z niego czytać nie będzie. Jeżeli czytamy z bazy i nie zamkniemy połączenia to nikt inny się nie połączy... itd.
 
 ## Q: No dobra to już każdy rozumie ale co z tym wszystkim ma wspólnego defer?
 
 Okazuje się, że czasem kod może wybuchnąć. I jeżeli na początku bloku kodu otwieramy coś co musimy zamknąć. Na końcu dajemy kod do posprzątania. A w środku coś wyrzuca wyjątkiem to kod sprzątający nigdy nie pobiegnie!
 
 Wymuśmy taką sytuację. Rzucimy błędem, który niżej zdefiniuję:
 */

enum SomethingExploded: Error {
    case badLuck
}

/*:
 Teraz zdefiniuję funkcję, która będzie wybuchać. Podzieliłem przez zero, zrobiłem `nil!`, wpadł kwant energii i przestawił bit w rejestrze procesora... Po prostu miałem pecha.
 */

func exploding() throws {
    print(#function, #line, "💥")
    throw SomethingExploded.badLuck
}

// Ignore this for now ;)
NSSetUncaughtExceptionHandler { exception in print("💥 Exception thrown", exception) }

/*:
 Pobiegnijmy kawałek pechowego kodu:
 */
xrun("👎🏻🍀 example") {  // change to `run` to run
    func usingExploding() throws {
        print(#line, "getting a resource")
        
        print(#line, "using it")
        try exploding()
        
        print(#line, "🧹🧹🧹🧹 CLEAN UP")
    }
    
    try! usingExploding()
}

/*:
 Na próżno szukać miotełek w konsoli. Tu właśnie z pomocą przychodzi defer.
 */

xrun("😎🍀 example") { // change to `run` to run
    
    func usingExploding() throws {
        print(#line, "getting a resource")
        defer {
            print(#line, "🧹🧹🧹🧹 CLEAN UP")
        }
        
        print(#line, "using it")
        try exploding()
        
        
        defer {
            print(#line, "😝 never executed")
        }
        print(#line, "never executed")
    }
    
    try! usingExploding()
}


/*:
 Widać, że z ofiarami ale udało się posprzątać. Oczywiście nigdy nie udało się wywołać ostatniej linijki. Ale też defer-a z "😝". Po prostu nigdy nie został odłożony "na stos" do wykonania więc nie było go aby go zdjąć.
 
 Logika do sprzątania po sobie jest blisko kodu gdzie "brudzimy". Łatwiej się to czyta szczególnie, że czasami ktoś może po prostu zapomnieć dopisać tą linijkę.
 */


//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
