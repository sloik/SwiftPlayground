//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## In-Out, Przekazywanie Typów Referencyjnych, Przekazywanie/Zwracanie Funkcji, Zagnieżdzone Funkcje

import UIKit

/*:
 Niżej zmienna `number` umożliwia przypisanie innej wartości:
 */

var number = 42

/*:
 Napiszemy funkcję do której dodamy adnotacje `@available`. Można jej użyć np. do poinformowania innych developerów kiedy jakaś funkcjonalność została wprowadzona, będzie wycofana lub dać wskazówkę czego można użyć zamiast.
 
 [Więcej atrybutów do @available można zobaczyć tu: Attributes](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Attributes.html)
 
 Funkcje definiują pewien kontrakt i czasem wymagają przekazania dodatkowych argumentów. Co ważne argumenty do funkcji są przekazywane jako stałe.
 */

@available(*, introduced: 1.2, deprecated: 2.0, message: "This method explodes please use: takesIntAndMutatesIt")
func takesInt(_ parametr: Int) {
    // 💥 Left side of mutating operator isn't mutable: 'parametr' is a 'let' constant
//    parametr -= 2 // uncomment to see compiler error
}

takesInt(number)
number

/*:
W funkcji `takesInt` nazwany argument jest przekazany jako stała. A co za tym idzie nie możemy go mutować. Gdy zachodzi taka potrzeba możemy stworzyć lokalną (dla funkcji) zmienna i ją mutować. Uwaga nazwa jest ta sama ale używamy tutaj mechanizmu przysłaniania (ang. shadowing).
*/
func takesIntAndMutatesIt(_ number: Int) {
    var number = number
    number -= 2
}

takesIntAndMutatesIt(number) // przekazana jest kopia
number

/*:
 W placu zabaw widać, że lokalnie funkcja faktycznie utworzyła kopie i wykonała operacje. Natomiast zmienna, która posłużyła jako argument do funkcji ma taką samą wartość jak przed wywołaniem funkcji.

 ### In - Out
 
 Aby móc zmienić przekazywany parametr musimy użyć słowa kluczowego __inout__ .
 */

func takeAnIntAndMutatesIt(_ number: inout Int) {
    guard number >= 2 else {
        return
    }

    number -= 2
}

number = 42
takeAnIntAndMutatesIt(&number)
number

/*:
Jak widać zmienna z poza funkcji ma wartość ustaloną wewnątrz funkcji. Co jest bardzo fajne język wymusza specjalną adnotacje przy pomocy symbolu `&`. Dzięki temu jasno widać, że dana wartość może zostać zamieniona.

 Co jest jeszcze ciekawsze nie dzieje się to jak by można było przypuszczać za sprawą przekazania referencji do mutowanego obiektu. Nawet taka funkcja dostaje swoją lokalną kopie. Jedyne co się różni to w momencie _zwracania_ wartości (kończenia funkcji) po oryginalny adres w pamięci komputera jest wpisywana zmutowana instancja.

 Można by się zastanowić po co tyle zachodu. I odpowiedzią jest wielowątkowość. Gdyby ta funkcja była uruchomiona na wielu wątkach to zachodziłoby ryzyko, że różne wątki w różnych momentach mutowałyby różne części obiektu. Jeżeli brzmi to zagmatwanie to dlatego, że trochę jest. Natomiast ponieważ w tym wypadku każde wywołanie otrzymuje swoją własną kopie to nie ma problemu ze współdzielonymi zasobami.
 */

//: Przydatną praktyką jest komentowanie metod. Dzięki temu w __Quick help__ będziemy mogli zobaczyć bardzo użyteczny opis.

/**
Przykładowa metoda służąca do pokazania w jaki sposób dodany komentarz pojawia się w podręcznej pomocy. Dobrą praktyką jest dokumentowanie co robi dana funkcja i czego się po niej można spodziewać.

- parameter input:  Przykładowy parametr wejściowy, zostanie zwrócony jako pierwszy w tuplecie.
- parameter output: Przykładowy parametr wyjściowy, zostanie zwrócony jako drugi w tuplecie.

- returns: Zwraca krotkę składającą się z przekazanych parametrów.
*/
func functionToDocument(_ input: String, output: Int) -> (in: String, out: Int) {
    return (input, output)
}

let willThisWork = functionToDocument("sprawdzam", output: 69)
willThisWork.in
willThisWork.1

//: ## Przekazywanie Typów Referencyjnych
//: W tym wypadku w argumencie funkcji dostaniemy referencje ("wskazanie") do obiektu a nie jego kopie.

let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
let view = UIView(frame: frame)
view.backgroundColor = UIColor.red
Unmanaged.passUnretained(view).toOpaque()
view

func takeInAView(_ view: UIView) {
    Unmanaged.passUnretained(view).toOpaque()
    view.backgroundColor = UIColor.green

//    view = UIView() // 💥
}

takeInAView(view)

view

//: Mimo, że __widok__ jest zdefiniowany jako stała (__let__) to ponieważ jest przekazany przez referencję wewnątrz funkcji można zmienić jego __nie stałe__ atrybuty.
//: > Natomiast gdy przekażemy do funkcji referencje (typ referencyjny) i dodatkowo ten parametr jest __inout__ to wtedy wewnątrz funkcji będziemy mogli całkowicie podmienić obiekt na zupełnie nowy.

func takeInAInOutView(_ view: inout UIView) {

    view = UIView(frame: CGRect(x: 0,y: 0, width: 50, height: 50))
    view.backgroundColor = UIColor.lightGray
}

var testView = UIView(frame: frame)
testView.backgroundColor = UIColor.yellow
testView

let referenceBefore = Unmanaged.passUnretained(testView).toOpaque()

takeInAInOutView(&testView)

let referenceAfter = Unmanaged.passUnretained(testView).toOpaque()

testView

referenceBefore == referenceAfter

//: ## Przekazywanie Funkcji Jako Argumentu Do Funkcji

func addNumbers(_ a: Int, _ b:Int) -> Int {
    return a + b
}
type(of: addNumbers)

func doOperation(_ operation: (Int, Int) -> Int, l1: Int, l2: Int) -> Int {
    operation(l1, l2)
}

let result = doOperation(addNumbers, l1: 40, l2: 2)
result

//: ## Zwracanie Funkcji i Zagnieżdżanie Funkcji
//: Funkcje mogą zwracać funkcje. Wtedy ich zwracany typ to typ zwracanej funkcji. Jeden przykład jest wart tysiąca słów... a na kanale mamy osobne odcinki, które zagłębiają się w temat żonglowania funkcjami.

func returnAnotherFunction() -> ( () -> String ) { // ... -> () -> String

    func quoteFunction() -> String {
        "Można pić bez obawień"
    }
    type(of: quoteFunction)

    return quoteFunction
}

let someFunction = returnAnotherFunction()
type(of: someFunction)

someFunction()

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
