//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Definiowanie i Wywoływanie Funkcji
//: __Funkcje__ to niezależne kawałki reużywalnego kodu. __Metody__ to funkcje należące do jakiegoś __typu__ np. instancji klasy.
//: Funkcje deklarujemy przy użycia słowa kluczowego __func__. Następnie nadajemy jej nazwę (_konwencja_ : notacjaWielbłądzia), parametry w nawiasach okrągłych i w klamerkach __ciało funkcji__ czyli kod jaki ma być wykonywany przy jej wywołaniu.
func justQuote() {
    print("Można pić bez obawień")
}

//: Funkcja przyjmująca parametr.
func sayHi(name: String) {
    print("Cześć \(name), będziesz to jeść?\n")
}

//: Funkcja przyjmująca więcej parametrów.
func quote(quote: String, author: String) {
    print("\"\(quote)\"\n\t\t-- \(author)\n")
}

//: Funkcje wywołujemy podając jej nazwę i przekazując w parametrach niezbędne argumenty. Co ciekawe pierwszy argument nie jest nazwany. To co widać przy wywołaniu funkcji to _zewnętrzna nazwa parametru_ . Nazwa parametru użyta wewnątrz to _wewnętrzna nazwa parametru_ . Domyślnie zewnętrzna i wewnętrzna nazwa parametru jest taka sama.
quote(quote: "Można pić bez obawień.", author: "Wiesław Wszywka")

func quoteWithArguments(quote: String, whoSaidId author: String) {
    print("\"\(quote)\"\n\t\t-- \(author)\n")
}

/*:
 Warto zauważyć, że `whoSaidId` jest widoczna _na zewnątrz_ funkcji. W momencie gdy jest wywoływana. Wewnątrz ciała funkcji (pomiędzy klamrami `{}`) jest już użyta, krótsza nazwa `author`. Dzięki temu kod może być bardziej zwięzły a wywołanie lepiej oddawać _intencję_.
 */

quoteWithArguments(quote: "Badziewie do badziewia.", whoSaidId: "Wiesław Wszywka")

//: Ponieważ są jeszcze pewne naleciałości nazewnicze z __Objective C👑__ to często pierwsza nazwa parametru znajduje się w nazwie metody.

func quoteAnQuote(_ quote: String, of author: String) {
    print("\"\(quote)\"\n\t\t-- \(author)\n")
}

quoteAnQuote("Niebo w ziemi.", of: "Wiesław Wszywka")

//: Jeżeli chcemy pozbyć się zewnętrznych parametrów w wywołaniu funkcji, możemy to zrobić zastepując je "_". Funkcje potrafią też zwracać wynik swojego działania. Oznacza się to przez strzłkę __ -> __ i podanie zwracanego typu.

func addTwoNumbers(_ number1: Int, _ number2: Int) -> Int {
    return number1 + number2
}

var sumOfNumbers = addTwoNumbers(40, 2)

/*:
 Typy argumentów oraz zwracany typ tworzą razem coś co nazywa się "typem funkcji".
 
 Natomiast gdy mówimy, że _coś jest jakiegoś typu_ to mamy na myśli, że może przyjąć wartość z góry ustalonego zbioru. Banalnym przykładem jest typ `Int`. Gdy jakaś zmienna/stała przechowuje wartość tego typu to wiemy, że może to być jakaś liczba całkowita np. -1, 42, etc.
 */
type(of: addTwoNumbers)

//: Możemy też stworzyć referencje (wskazanie), która będzie "przechowywać" funkcje. Kluczowe jest użycie __samej__ nazwy funkcji.

let function = addTwoNumbers

sumOfNumbers = function(60, 9)

//: Możemy przypisać domyślne wartości dla parametrów funkcji. Lepiej jest umieszczać takie parametry na końcu listy. Dzięki temu możemy pominąć te parametry przy wywoływaniu funkcji.

func quoteWithDefaultParameters(_ quote: String, author: String, times: Int = 1) {
    for _ in 0..<times {
        quoteAnQuote(quote, of: author)
    }
}

quoteWithDefaultParameters("Kur zapiał!", author: "Wiesław Wszywska")

//: Funkcje mogą przyjmować też opcjonalne argumenty. Co fajne ponieważ w tym wypadku nadajemu mu domyślną wartość jako __nil__ to przy wywołaniu możemy pominąć ten agrument.

func quoteWithOptionalAuthor(_ quote: String, author: String? = nil) {
    let quoteAuthor = author ?? "Anonim"
    quoteAnQuote(quote, of: quoteAuthor)
}

quoteWithOptionalAuthor("Gdzie kucharek sześć tam...")

/*:
A co jeżeli nie wiemy ile chcemy tych parametrów... na to mamy i takiego wariata ;) Aby określić, że funkcja przyjmuje zmienną ilość argumentów za typem parametru dodajemy "...". Wewnątrz funkcji otrzymamy Swiftową tablicę tego typu. Trzeba przyznać, że jest to o wiele przyjemniejsza składnia niż w C/ObjC.

Napiszemy funkcję, która zsumuje wszystkie przekazane liczby. Zrobimy to przy użyciu innej funkcji o nazwie `reduce`. Jak ta funkcja działa nie jest ważne w tym momencie. Istotne jest to, że w jednej funkcji możemy wywoływać inne funkcje.d
 */
func sumNumbers(_ numbers: Int...) -> Int {
    type(of: numbers)

    return numbers.reduce(0, +)
}

sumNumbers(1,2,3,4,5)

/*:
 ## Przeciążanie Funkcji

 Dobra nazwa jest jak złoto. Nie warto jej marnować dlatego istnieje mechanizm w języku pozwalający na ponowne jej użycie. To czym się musi różnić to typy argumentów.

 */

func doStuff(_ z: String) { z }
func doStuff(_ z: Int) { z }
//type(of: doStuff) // 💥 biedak nie wie którą zawołać

//: W tym wypadku Swift podejmuje decyzję którą funkcje zawołać w czasie kompilacji. Sprawy mają się troszeczkę inaczej jeżeli funkcja/metoda zdefiniowana w klasie i inna klasa ją przeciąża, ale o tym póxniej 🤓
type(of: (doStuff as (String)->Void))
type(of: (doStuff as (Int)->Void))

/*:
## Zwracana Wartość

 **Każda funkcja w Swift zwraca wartość!**. Typ zwracanej wartości może być pominięty jeżeli jest to `Void` lub jak wiemy pusta krotka `()`. Nie musimy jego deklarowac i nie musimy jego zwracać. Kompilator zrobi to za nas. Poniższe dwie funkcje maja ten sam typ i _pod spodem_ są identyczne.
 */

func returnVoidSilent() {}
func returnVoidExplicit() -> Void { return () }

type(of: returnVoidSilent)
type(of: returnVoidExplicit)

/*:
W obu przypadkach typ jest `() -> ()` czyli "funkcja, która nie przyjmuje żadnych argumentów i **nic** nie zwraca". Zaraz, zaraz. Powiedziałem, że nic nie zwraca a jednak zwraca? To jak to jest?

 To cudo _zwracane_ na końcu funkcji to jest taki sprytny _hak_ aby komputer wiedział kiedy funkcja zakończyła działanie. Nazwa `Void` sugerująca _nic_ lub _próżnię_ w tym wypadku jest trochę myląca. Przecież pusta krotka to nie jest nic! Natomiast nie mamy za dużego wyboru i w zależności od kontekstu może znaczyć różne rzeczy. Polecam poszukać "bottom" jeżeli ten wątek wydaje się interesujący.

 */


//: Bardzo ciekawym przypadkiem są [__operatory__](07_05_operatory) (+, -, *, / etc.) gdyż są one przeciążonymi funkcjami (ten sam symbol używam do _łączenia_ różnych wartości).

 6  +  9 // klikamy z altem na "+"
"a" + "b"
[1] + [2]

//: Możemy nawet taki operator przypisać do zmiennej jednak musimy podać konkretny "wariant przeciążenia" aby kompilator wiedział o którą wersje nam chodzi.

let adder: (Int, Int) -> Int = (+)
adder(6,9)

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
