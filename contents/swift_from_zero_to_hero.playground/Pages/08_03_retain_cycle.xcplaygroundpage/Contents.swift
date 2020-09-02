//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Retain Cycle](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID51)

/*:
## Uwaga na typy referencyjne 💥
Bardzo często w trakcie pisania kodu musimy wewnątrz jednej klasy umieścić wskazania (referencje) na obiekty z innej klasy. Samo w sobie nie jest to groźne, natomiast z racji tego w jaki sposób w Swift zarządza pamięcią może doprowadzić do wycieku pamięci.

## Zarządzanie pamięcią kurs bardzo przyśoieszony.
Każdy obiekt gdzieś pod spodem ma przypisany ukryty licznik, który mówi ile innych obiektów trzyma do niego wskazanie (referencje). Ta _ukryta_ właściwość każdego obiektu, który powstał nazywa się __retain count__.

Zasady są bardzo proste:
* _Każde_ ( _chwilowo kłamię, ale się to wyjaśni dalej_ ) wskazanie na obiekt zwiększa wartość tego licznika o +1. 
* Gdy referencja jest _wynilowana_ lub w inny sposób przestaje wskazywać na obiekt wartość tego licznika jest zmniejszana o -1.
* Gdy wartość licznika spada do 0 obiekt jest niszczony a jego pamięć jest zwalniana do systemu.

Cała ta _księgowość_ dzieje się automatycznie i nie musimy w nią w żaden sposób ingerować. Musimy natomiast być jej świadomi (trzymać gdzieś w piwnicy razem z innymi rzeczami, które czasem nas straszą).

## Cykliczne Referencje

Wiedząc już jak działa ta _księgowość_ wyobraxmy sobie sytuacje w której obiekt klasy __A__ ma referencje do obiektu klasy __B__ i to ponownie do obiektu __A__.

![retain cycle](retain-cycle-copy.png)

Jak widać każdy z nich w takiej sytuacji ma retain count równy +1.

*/

protocol MustHaveParent {
    var parent: Parent? { get set }
}

class Parent {
    let children: [MustHaveParent]

    @discardableResult
    init(children: [MustHaveParent]) {
        print(type(of: self), #function)
        
        self.children = children

        for var child in children {
            child.parent = self
        }
    }

    deinit { print(type(of: self), #function) }
}

class Child: MustHaveParent {
    var parent: Parent?

    init(){ print(type(of: self), #function) }

    deinit { print(type(of: self), #function) }
}



run("🧑‍🔬 No deinit!") {
    Parent(
        children: [
            Child()
        ]
    )
}

/*:
## Słabe Referencje

Aby zaradzić tej sytuacji mamy do dyspozycji dwa mechanizmy które sprawiają, że retain count obiektu na który jest wskazanie **nie wzrasta**. Jednym z nich jest słowo kluczowe [**weak**](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID53) a drugim [ **unowned** ](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID54).

![retain cycle](retain-cycle-broken.png)

### Kiedy używać którego?
* **weak** uzywamy w momencie gdy referencja może być nil 
* **unowned** gdy referencja zawsze musi mieć wartość
*/

class MemorySafeChild: MustHaveParent {
    weak var parent: Parent?

    init(){ print(type(of: self), #function) }

    deinit { print(type(of: self), #function) }
}

run("👗 No leaking memory") {
    Parent(
        children: [
            MemorySafeChild()
        ]
    )
}

//: **Bloki**, ponieważ "łapią" obiekty w dostepnym zakresie (scope), **również mogą spowodować retain cycle**. W miejscu gdzie w bloku uzywamy jakiejś zmiennej z poza bloku kompilator tworzy i "dowiązuje" specjalny obiekt, który jest używany do "złapania" referencji lub użytych wartości.

class LeakingMemory {

    var counter = 0

    lazy var blok: () -> () = {
        // Instancja trzyma blok a blok przez użycie self instancje!
        self.counter += 1
        print(type(of: self), #function)
    }

    init() { print(type(of: self), #function) }

    deinit { print(type(of: self), #function) }
}

run("🍄 Leaking") {
    let leakingInstance = LeakingMemory()
    leakingInstance.blok()
}

//: Podobnie jak wcześniej na ratunek przychodza nam słowa weak ora unowned. Podając je mówimy kompilatorowi w jaki sposób ten obiekt ma trzymać referencje do użytych zmiennych. [Dokumentacja](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID56)

class NotLeaking {
    var counter = 0

    lazy var blok: () -> () = { [unowned self] in // self nie zwiększa już retain count
        self.counter += 1
        print(type(of: self), #function)
    }

    init() { print(type(of: self), #function) }

    deinit { print(type(of: self), #function) }
}

run("🦄 Not leaking") {
    let instance = NotLeaking()
    instance.blok()
}

//: Podane tutaj przykłady są relatwynie proste! I raczej są łatwe do zauważenia wiekszy problem jest w momencie kiedy _łańcuszek_ obiektów jest dłuższy. Nie możemy też polegać na statycznej analizie kodu gdyż ta nie zawsze jest w stanie wykryć tego typu zależności (chociaż czasem radzi sobie zaskakująco dobrze).

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
