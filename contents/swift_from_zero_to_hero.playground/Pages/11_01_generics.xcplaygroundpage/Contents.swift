//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Generyki](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html)

import Foundation

/*:
W Swift każda stała lub zmienna mają zadeklarowany typ. Dzięku temu zawsze (prawie zawsze) wiemy z jakiego _typu_ obiektem mamy do czynienia. Gdy potrzebujemy nieco rozluźnić "więzy" możemy zadeklarować zmienną jako _Any_ lub _AnyObject_. Dodatkowo mając protokoły znamy interfejs danego typu i możemy bezpiecznie wywoływać na nim metody. Jeżeli natomiast mamy potrzebę sprawdzenia z jakim konkretnie typem teraz pracujemy możemy zkastować na odpowiedni typ (oczywiście wymaga to sprawdzenia czy instancja z którą teraz pracujemy jest tego typu). **Generyki** pozwalają nam zachować "gwarancje typu" i pozwalają nam pracować bezpośrednio z instancją bez wymogu kastowania (ang. cast).

Kilka przykładów:
*/

let strings: Array<String> = []
type(of: strings)

let ints: Array<Int> = []
type(of: ints)

struct 💩 { var id: Int  }

//: 💡: Zobacz jak zadeklarowana jest tablica w standardowej bibliotece (cmd + double click)

let 💩s: Array<💩> = []
type(of: 💩s)

/*:
Wygląda na to, że już zupełnie niechcący generyki były wykorzystywane na potęgę i nawet o tym nie wiedzieliśmy!
*/

let dictionaryOfStringInt: Dictionary<String, Int> = [:] //💡: Więcej jak jeden typ (argument) generyczny
type(of: dictionaryOfStringInt)

let setOfStrings: Set<String> = []
type(of: setOfStrings)

let maybeQuote: Optional<String> = .none

/*:
 Generyki można też definiować w funkcjach. Poniżej przykład z funkcją `swap` dostępną w bibliotece standardowej Swift.
 */

run("🤽‍♂️ swap"){
    var foo      = 4  ;  var bar      = 2
    var floatFoo = 4.2;  var floatBar = 6.9
    
    print("Przed", foo, bar, floatFoo, floatBar)
    
    swap(&foo , &bar )
    swap(&floatFoo, &floatBar)
    
    print("   Po", foo, bar, floatFoo, floatBar)
}

/*:
 
 Funkcje generyczne to inny rodzaj polimorfizmu. Trudny i straszny wyraz. Może kilka przykładów aby _poczuć_ o co chodzi. **Chciałbym napisać funkcję, która zwróci mi przekazany argument**. Taka funkcja wydaje się mało użyteczna, co jest nie prawdą. Jest bardzo użyteczna i potrzebna!
 
 */

func identityInt   (_ a: Int   ) -> Int    { a }
func identityString(_ a: String) -> String { a }

/*:

 Łatwo sobie wyobrazić więcej takich funkcji. Jednak jest z tym kilka problemów. Po pierwsze duplikuje kod i muszę go pisać dla każdego typu jaki jest. Inaczej nie mogę zawołać tej funkcji z instancją tego typu. Kolejny problem to, że w implementacji nie wykorzystuję żadnej wiedzy o tym konkretnym typie. Na sam koniec widać gołym okiem, że ten kod jest identyczny! Różni się tylko typem na wejściu i wyjściu, który jest taki sam!
 
 # Definiowanie Funkcji Generycznych
 
 Jedyną różnicą między zwykłą funkcją a funkcją generyczną jest podanie listy generyków w nawiasach `<>` między nazwą a listą argumentów. Zobaczmy...
 */

func identity<A>(_ a: A) -> A { a }

run("🆔 identity"){
    print( identity(42), identity("wow") )
}

/*:
 
 Funkcja `identity` ma jeden typ generyczny o nazwie `A`. Przyjmuje jako argument instancję typu `A`. Ta sama implementacja działa dla `Int` i dla `String`. Zadziała również i dla każdego innego typu, który powstanie w przyszłości. To wszystko bez potrzeby rekompilowania kodu!
 
 Wisienką na torcie jest to, że ponieważ nic nie wiemy o typie `A` to nie możemy wywołać na nim żadnej metody. Sprawdzić żadnego property! Dzięki temu można pisać bardziej ogólne algorytmy. Napisać testy dla tych generycznych algorytmów i spokojnie reużywać! Unikać niepotrzebnych powtórzeń w kodzie.
 
 Parametrów generycznych może być więcej.

 */

func tupleSwap<A,B>(_ tuple: (A, B)) -> (B, A) { (tuple.1, tuple.0) }

run("🐶 tupleSwap"){
    print(
        tupleSwap( (  42, "wow") )
    )
    print(
        tupleSwap( ("🧩", "🎈" ) )
    )
}

/*:
 W pierwszym przykładzie typy `A` i `B` były różne. W drugim takie same! Wynika z tego, że **jeżeli jest więcej typów generycznych to mogą być one takie same**. Nie ma przymusu aby były inne!

 ## Własne Typy Generyczne
 
 Do definiowania własnych typów, które są generyczne wykorzystujemy składnię `<Token>` (tyczy się to typów i funkcji/metod). Gdzie `Token` jest dowolnym string-iem po którym się odwołujemy do konkretnego i zawsze tego samego typu. Array używa nazwy `Element`, Optional `Wrapped` etc. Często też można się spotkać z jedno literowymi oznaczeniami `T`, `U` itd.
 */


run("🧩 custom") {

    final class Wrapper< Wrapped > {
        var wrap: [Wrapped]

        init(wrap: [Wrapped]) { self.wrap = wrap }

        var random: Wrapped { wrap.randomElement()! }
    }

    let numbers  = [4, 2, 6, 9]
    let strings = ["Można", "pić", "bez", "obawień"]

    let numberWrapper  = Wrapper(wrap: numbers)
    let stringsWrapper = Wrapper(wrap: strings)

    print( numberWrapper.random, type(of: numberWrapper.random) )
    
    print( stringsWrapper.random, type(of: stringsWrapper.random) )
}

/*:
 
 Wrapper przechowuje _coś_ typu `Wrapped`. Nie wiemy co to jest. Nie można zawołać na tym żadnej metody czy sprawdzić property. Wiemy tylko tyle _że jest_.
 
 Jeżeli byłoby więcej typów generycznych to by były zdefiniowane po przecinku np. `class Wrapper <X,Y,Z>`. W tym przykładzie są trzy typy generyczne. Każdy z nich pozwala wstawić inny konkretny typ np. `Wrapper<Int, String, Float>`. Nie musi tak być, ta sama definicja (X,Y,Z) zadziała dla `Wrapper<Int, Int, Int>`. Jedyne co to mówi to, że jest taka możliwość a nie obowiązek.

 ## Ograniczanie Generyków
 
 Mając typ o którym nic nie wiemy i nic z nim nie możemy zrobić może być plusem a może czasem wiązać ręce. Czasem chcemy pracować z instancją czegoś co ma jakieś właściwości i/lub metody lub konformuje do protokołu.
 
 Istnieje składnia, która pozwala na nałożenie dodatkowych ograniczeń co do typu.
 
 */

protocol Jumpable {}
protocol Singable {}

/*:
 Chcę stworzyć taką klasę, która będzie kontenerem ale tylko dla takich typów, które konformują do `Jumpable` i `Singable`.
 */

run("👀 generic constraint") {

    final class Wrapper< Wrapped > where Wrapped: Jumpable, Wrapped: Singable  {
        var wrap: [Wrapped]

        init(wrap: [Wrapped]) { self.wrap = wrap }

        var random: Wrapped { wrap.randomElement()! }
    }

    struct Jumper       : Jumpable           {}
    struct Singer       : Singable           {}
    struct JumpingSinger: Jumpable, Singable {} // 👍🏻

    let jumpers = [Jumper(), Jumper()]
    print(type(of: jumpers))

    let singers = [Singer(), Singer()]
    print(type(of: singers))

    let artists = [JumpingSinger(), JumpingSinger()]

//  💥 Generic class 'Wrapper' requires that 'Jumper' conform to 'Singable'
//    Wrapper(wrap: jumpers)

//  💥 Generic class 'Wrapper' requires that 'Singer' conform to 'Jumpable'
//    Wrapper(wrap: singers)

    let wrapper = Wrapper(wrap: artists)

    let mysteryItem = wrapper.random

    print(
        "What is it:", type(of: mysteryItem)
    )
}

/*:
 
 Składnię ze słowem kluczowym `where` można zastąpić `Wrapper< Wrapped: Jumpable, Singable >`. Czasem czytelniej jest umieścić ograniczenia za a czasem wewnątrz.
 
 # [Generyki w Protokołach / Associated Types](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID189)
 
 Teraz połączymy świat protokołów i generyków.
 */

protocol Wrappable {
    associatedtype WrappedType // aby ograniczyć typ używamy składni ``: Jumpable``

    var howManyWrapped: Int { get }
    
    mutating func wrap(element: WrappedType)
}

/*:
 Słowo kluczowe `associatedtype` występujące w definicji protokołu jest placeholderem na typ. Czyli jest generykiem! Mówimy tym protokołem, że będziemy owijać jakiś konkretny typ `WrappedType`. W czasie definiowania protokołu jeszcze nie wiemy jaki. Ktoś jak będzie do niego konformować będzie musiał to powiedzieć.
 
 Reszta jest dość standardowa. Jedno property i jedna metoda.
 */

class Wrapper< IWrapThisType >: Wrappable {
    
    typealias WrappedType = IWrapThisType
    
    var wraps: [IWrapThisType] = []
    init(wraps: IWrapThisType...) {
        self.wraps = wraps
    }
    var howManyWrapped: Int { wraps.count }
    
    func wrap(element: IWrapThisType) {
        wraps.append(element)
    }
}

/*:
 
 Linijka `typealias WrappedType = IWrapThisType` mówi dla kompilatora, że tym typem który owijam jest mój generyk. Tu jest troszeczkę gęsto ponieważ sam wrapper posiada typ generyczny. Po prostu przekazujemy go dalej. Jeżeli by go nie miał to dla _zawijacza_ intów można by było napisać np. tak: `typealias WrappedType = Int`. Jednak nie chcemy pisać 500 różnych wersji i dlatego łączymy te dwa światy.
 
 */

run("🦆 associated type") {
    let intsWrapper = Wrapper(wraps: 4)
    print("intsWrapper jest typu:", type(of: intsWrapper) )

    intsWrapper.wrap(element: 2)
    intsWrapper.howManyWrapped
    intsWrapper.wraps

    let intsWrapperFirst = intsWrapper.wraps.first!
    print("Owijany element to:", intsWrapperFirst, "typu", type(of: intsWrapperFirst) )

    __
    
    let stringsWrapper = Wrapper(wraps: "Można")
    print("stringsWrapper jest typu:", type(of: stringsWrapper) )
    
    stringsWrapper.wrap(element: "pić")
    stringsWrapper.wrap(element: "bez")
    stringsWrapper.wrap(element: "obawień")
    stringsWrapper.howManyWrapped
    stringsWrapper.wraps
    
    let stringsWrapperFirst = stringsWrapper.wraps.first!
    print("Owijany element to:", stringsWrapperFirst, "typu", type(of: stringsWrapperFirst) )
}


/*:
 
 Okazuje się, że jeżeli kompilator jest w stanie wydedukować typ to to zrobi. Dzięki czemu nie musimy definiować tego aliasu. Jednak z własnego doświadczenia polecam to zrobić. Nie zawsze to co dostaniemy może być tym czego chcemy (szczególnie gdy framework z którego korzystamy ma wiele generyków). Ewentualnie zawsze można dodać go potem ;)
 
 */

protocol Rememberable {
    associatedtype RememberedType

    mutating func remember(something: RememberedType)
    var something: RememberedType? { get }
}

struct Mnemo< GMO >: Rememberable {
    var gmos: [GMO] = []

    init(_ gmo: GMO) { remember(something: gmo) }

    mutating func remember(something: GMO) { gmos.append(something) }

    var something: GMO? { gmos.last }
}

/*:
 
 Tym razem nie napisałem typealiasu aby wskazać jaki jest generyk. Kompilator jest w stanie to wyinferować na podstawie typu metody `remember(something:..)`.
 
 Zobaczmy jak to działa...
 
 */


run("🐡 nemo") {
    
    var intsMnemo = Mnemo(4)
    intsMnemo.remember(something: 4)
    intsMnemo.remember(something: 2)
    intsMnemo.gmos
    
    print("intsMnemo ma typ:", type(of: intsMnemo), "i zawiera", intsMnemo.gmos )
    
    __
    
    var stringsMnemo = Mnemo("można")
    type(of: stringsMnemo)
    stringsMnemo.remember(something: "pić")
    stringsMnemo.remember(something: "bez")
    stringsMnemo.remember(something: "obawień")
    stringsMnemo.gmos
    
    print("stringsMnemo ma typ:", type(of: stringsMnemo), "i zawiera", stringsMnemo.gmos )
}

/*:
 
 W tym momencie powiedzieliśmy sobie bardzo dużo ale nie wszystko o generykach. Najtrudniej jest zacząć, ale uważaj! Niech to nie będzie wielki młotek, który rozwiązuje każdy problem. Generyki występują często, łatwo je spotkać i są użyteczne. Zacznij powoli od unikania duplikacji w kodzie. Potem dorzuć jeszcze ograniczenia (generics constraints) aby w pełni wykorzystać ich moc.
 
 */

print("🦄")

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)


