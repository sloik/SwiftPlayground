//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Definiowanie i Wywoływanie Funkcji
//: __Funkcje__ to niezależne kawałki reużywalnego kodu. __Metody__ to funkcje należące do jakiegoś __typu__ .

//: Funkcje deklarujemy przy użycia słowa kluczowego __func__. Następnie nadajemy jej nazwę (_konwencja_ : notacjaWielbłądzia), parametry w nawiasach okrągłych i w klamerkach __ciało funkcji__ czyli kod jaki ma być wykonywany przy jej wywołaniu.
func cytujCytat() {
    print("Można pić bez obawień")
}

//: Funkcja przyjmująca parametr.
func przywitaj(_ imie: String) {
    print("Cześć \(imie), będziesz to jeść?\n")
}

//: Funkcja przyjmująca więcej parametrów.
func cytuj(_ cytat: String, autor: String) {
    print("\"\(cytat)\"\n\t\t-- \(autor)\n")
}

//: Funkcje wywołujemy podając jej nazwę i przekazując w parametrach niezbędne argumenty. Co ciekawe pierwszy argument nie jest nazwany. To co widać przy wywołaniu funkcji to _zewnętrzna nazwa parametru_ . Nazwa parametru użyta wewnątrz to _wewnętrzna nazwa parametru_ . Domyślnie zewnętrzna i wewnętrzna nazwa parametru jest taka sama.
//cytuj("Można pić bez obawień.", autor: "Wiesław Wszywka")

func cytujZParametrami(_ cytat: String, autorCytatu autor: String) {
    print("\"\(cytat)\"\n\t\t-- \(autor)\n")
}

//cytujZParametrami(cytat: "Badziewie do badziewia.", autorCytatu: "Wiesław Wszywka")

//: Ponieważ są jeszcze pewne naleciałości nazewnicze z __Objective C👑__ to często pierwsza nazwa parametru znajduje się w nazwie metody.

func cytujCytat(_ cytat: String, autorCytatu autor: String) {
    print("\"\(cytat)\"\n\t\t-- \(autor)\n")
}

//cytujCytat("Niebo w ziemi.", autorCytatu: "wiesław Wszywka")

//: Jeżeli chcemy pozbyć się zewnętrznych parametrów w wywołaniu funkcji, możemy to zrobić zastepując je "_". Funkcje potrafią też zwracać wynik swojego działania. Oznacza się to przez strzłkę __ -> __ i podanie zwracanego typu.

func dodajDwieLiczby(_ liczba1: Int, _ liczba2: Int) -> Int {
    return liczba1 + liczba2
}

var sumaLiczb = dodajDwieLiczby(40, 2)

//: Typy argumentów oraz zwracany typ tworzą razem coś co nazywa się "typem funkcji".
type(of: dodajDwieLiczby)

//: Możemy też stworzyć zmienną, która będzie nam "przechowywać" funkcje. Kluczowe jest użycie __samej__ nazwy funkcji.

let funkcja = dodajDwieLiczby

sumaLiczb = funkcja(60, 9)

//: Możemy przypisać domyślne wartości dla parametrów funkcji. Lepiej jest umieszczać takie parametry na końcu listy. Dzięki temu możemy pominąć te parametry przy wywoływaniu funkcji.

func cytujDomyslneParametry(_ cytat: String, autor: String, ileRazy: Int = 1) {
    for _ in 0..<ileRazy {
        cytuj(cytat, autor: autor)
    }
}

//cytujDomyslneParametry("Kur zapiał!", autor: "Wiesław Wszywska")

//: Funkcje mogą przyjmować też opcjonalne argumenty. Co fajne ponieważ w tym wypadku nadajemu mu domyślną wartość jako __nil__ to przy wywołaniu możemy pominąć ten agrument.

func cytujCytatOpcjonalnyAutor(_ cytat: String, autor: String? = nil) {
    let autorCytatu = autor ?? "Anonim"
    cytuj(cytat, autor: autorCytatu)
}

//cytujCytatOpcjonalnyAutor("Gdzie kucharek sześć tam...")

//: A co jeżei nie wiemy ile chcemy tych parametrów... na to mamy i takiego wariata ;) Aby określić, że funkcja przyjmuje zmienną ilość argumentów za typem parametru dodajemy "...". Wewnątrz funkcji otrzymamy Swiftową tablicę tego typu. Trzeba przynać, że jest to o wiele przyjemniejsza składnia niż w C/ObjC.

func sumujLiczby(_ liczby:Int...) -> Int {
    type(of: liczby)

    return liczby.reduce(0, +)
}

sumujLiczby(1,2,3,4,5)

//: ## Przeciążanie Funkcji

func robiCos(_ z: String) { z }
func robiCos(_ z: Int) { z }
//robiCos.dynamicType // 💥 biedak nie wie którą zawołać

//: W tym wypadku Swift podejmuje decyzję którą funkcje zawołać w czasie kompilacji. Sprawy mają się troszeczkę inaczej jeżeli funkcja/metoda zdefiniowana w klasie i inna klasa ją przeciąża, ale o tym póxniej 🤓
type(of: (robiCos as (String)->Void))
type(of: (robiCos as (Int)->Void))
//func robiCos(zCzymsInnym: Int) {} // 💥

//: Bardzo ciekawym przypadkiem są [__operatory__](07_05_operatory) (+, -, *, / etc.) gdyż są one przeciążonymi funkcjami.

6 + 9 // klikamy z altem na "+"

//: Możemy nawet taki operator przypisać do zmiennej jednak musimy podać konkretny "wariant przeciążenia" aby kompilator wiedział o którą wersje nam chodzi.

let dodawacz: (Int, Int) -> Int = (+)
dodawacz(6,9)

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
