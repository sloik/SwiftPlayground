//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Protocols](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html)
/*:
 Najłatwiej myśleć o protokołach jak o kontrakcie zawierającym wymagania, które adoptujący typ (struktura/klasa/typ prosty) "obiecuje" spełnić. Jeżeli taka sytuacja nastąpi to mówimy, że dany typ implementuje dany protokół.
 
 W definicji protokołu mogą się znajdować metody jak rownież i właściwości oraz domyślne implementacje tych metod. Dodatkowo protokoły mogą dziedziczyć po sobie. Co pozwala na komponowanie protokołów (łączenie kliku w jeden).
 */

import Foundation

/*:
 ## Definiowanie Protokołu
 */

protocol WeatherAnchor {
    var humidity   : Int { get }
    var temperature: Int { get set } // let 💥
    
    func weatherStatus()
}

//: ## Dziedziczenie Protokołów
//: Podajemy listę protokołów po ":" oddzielając je przecinkami. Dodatkowo jeżeli chcemy aby protokół mogły implementować tylko klasy jako pierwsze piszemy słowo kluczowe **class**.

protocol TvAnchor: class, WeatherAnchor {
    var name: String { get }
    var age : Int? { get }
    
    init(nameOfAnchor: String, ageOfAnchor: Int?) // 💡
    
    //: Tylko klasy dziedziczące z NSObject (lub po klasie, która dziedziczy z NSObject) mogą implementować opcjonalne metody. Wiąże się to z tym, że protokoły w ObjC mogły posiadać opcjonalne metody. W _czystym_ swift nie można zdefiniować takiego protokołu.
    //    optional func optionalMethod() -> Void // 💥 "'optional' can only be applied to members of an @objc protocol"
}

/*:
 Protokól `TvAnchor` ma wymaganie aby tylko klasy mogły do niego konformować. Poniższy kod się nie skompiluje mimo że implementuje wszystkie wymagande property i metody!
 */

/*:
 💥 "non-class type 'StructCantImplementClassProtocols' cannot conform to class protocol 'TvAnchor'"
 */
//struct StructCantImplementClassProtocols: TvAnchor {
//    var name: String
//    var age: Int?
//    var humidity: Int
//    var temperature: Int
//
//    required init(nameOfAnchor: String, ageOfAnchor: Int?) {
//        name = nameOfAnchor
//        age = ageOfAnchor
//    }
//
//    func weatherStatus() {}
//}
/*:
 Jeszcze jeden protokół, aby było co implementować. Tym razem zawrzemy w nim pomysł czegoś co potrafi liczyć istniejące instancje.
 
 > Nie należy korzystać z tego kodu ponieważ w pewnych momentach działa źle! Natomiast widzieliśmy go we wcześniejszych placach zabaw więc nie powinien być taki obcy tu!
 */

protocol InstanceCauntable {
    static var instanceCounter: Int { get }
    
    static func numberOfInstances() -> Int
}

/*:
 # Implementowanie Protokołu
 
 ## Domyślna Implementacja
 
Za pomocą rozszerzeń można dodać domyślną implementacje dla protokołu. Można też dodać extra API, które nie jest zdefiniowane w protokole. Jednak to już jest kwestia tego jak działają rozszerzenia.
 
 > O rozszerzeniach dowiesz się w przyszłości. No chyba, że już je znasz to brawo Ty!

 */

extension InstanceCauntable {
    static func numberOfInstances() -> Int {
//: `Self` oznacza typ implementujący protokół. `self` oznacza instancje.
        Self.instanceCounter
    }
}

/*:
 Ponieważ protokół posiada domyślną implementacje to każdy konformujący typ już nie musi jej dostarczać. Może, ale nie jest to wymagane.
 */

class ProtocolsImplementer: TvAnchor, InstanceCauntable {
    // PogodynkaTV
    var name: String
    var age : Int?
    
    // Pogodynka
    fileprivate(set) var humidity: Int = 69 // protokół wymaga tylko gettera
    var temperature: Int = 24
    
    func weatherStatus() {
        print("Wilgotnosc: \(humidity)\tTemperatura: \(temperature)")
    }
    
    // InstanceCauntable
    static var instanceCounter: Int = 0
    
    // Pozostałe Metody Typu
    required init(nameOfAnchor: String, ageOfAnchor: Int? = nil) {
        name = nameOfAnchor
        age  = ageOfAnchor
        
        ProtocolsImplementer.instanceCounter += 1
    }
    
    deinit {
        ProtocolsImplementer.instanceCounter -= 1
    }
    
    func updateHumidity(_ newHumidity: Int) {
        humidity = newHumidity
    }
}

/*:
## Przykłady :)
 
 Tworzymy instancje `anchor` i ustawiamy trochę wartości:
 */

var anchor = ProtocolsImplementer(nameOfAnchor: "Sandra")

run("🥺 anchor"){
    anchor.weatherStatus()
    anchor.updateHumidity(80)
    anchor.weatherStatus()
    
    print(#line, "Liczba instancji:", ProtocolsImplementer.numberOfInstances())
}

/*:
 Liczba instancji się zgadza oraz metody. Dodajmy jeszcze jedna instancje:
 */

run("🍁 one more instance") {
    
    do {
        ProtocolsImplementer(nameOfAnchor: "Natalia") // 💡 żyje na stosie
        print(#line, "Liczba instancji:", ProtocolsImplementer.numberOfInstances())
    }
    
    print(#line, "Liczba instancji:", ProtocolsImplementer.numberOfInstances())
}

/*:
 W Swift kolekcje mogą posiadać tylko jeden typ. Np. nie wrzucimy do jednej tablicy instancji String oraz Int. To znacz wrzucimy, ale kompilator potraktuje to jako `Any` z którym nic nie można zrobić. Trzeba sprawdzić z jakim typem pracujemy i... generalnie robi się włochato.
 
 To co możemy zrobić to powiedzieć, że kolekcja będzie przechowywać instancje _czegoś co konformuje_ do protokołu.
 
 Jeszcze jedna klasa...
 */

class SomeCauntableImplementerType: InstanceCauntable {
    static var instanceCounter: Int = 0
}

/*:
Czas utworzyć kolekcje... ale co jeżeli chcemy aby ta kolekcja przechowywała instancje obiektów, które konformują do kilku protokołów? Wystarczy w deklaracji typu użyć `&` i wymienić wszystkie protokoły. Jest to **kompozycja protokołów**:
 */

var conformers: [WeatherAnchor & InstanceCauntable] = []

run("🧣 conformer"){
    print(
        type(of: conformers)
    )
}

/*:
 Takie podejście sprawia, że warto mieć dużo małych protokołów. Gdy potrzeba większej ilości funkcjonalności to wystarczy je ze sobą posklejać.
 
 > Mały protokół (z małą listą _wymagań_) jest łatwiej zaimplementować!
 
 Jeżeli jakieś protokoły często występują razem to warto nadać im nazwę za pomocą type aliasu:
 */

typealias SelfCauntableAnchor = WeatherAnchor & InstanceCauntable

/*:
 lub korzystając z **dziedziczenia** protokołów:
 */

protocol WeatherCauntable: WeatherAnchor, InstanceCauntable {}

/*:
 W pierwszym wypadku mamy alias, którym się możemy posługiwać. W drugim tworzymy całkiem nowy typ.
 */

let typeAliasedArray: [SelfCauntableAnchor] = []
let inheritedArray  : [WeatherCauntable]    = []

type(of: conformers)
type(of: conformers) == type(of: typeAliasedArray)
type(of: conformers) == type(of: inheritedArray)

/*:
 Jak widać chociaż funkcjonalnie (właściwości i metody) są identyczne. To jednak dlatego, że przy dziedziczeniu jest tworzona definicja nowego typy. Kompilator traktuje je jako coś innego.
 
 Instancja (typ instancji) `anchor` konformuje do tych protokołów. Tak więc możemy ją dodać do kolekcji:
 */


conformers.append(anchor)

/*:
 Gdy nie wszystkie warunki są spełnione to kompilator nie pozwoli wykonać takiej operacji:
 */

let someSelfCauntable = SomeCauntableImplementerType()

// 💥 argument type 'SomeCauntableImplementerType' does not conform to expected type 'WeatherAnchor'
//conformers.append( someSelfCauntable )

/*:
 ## Delikatna Introspekcja
 
 Czasami chcemy wiedzieć czy jakiś typ implementuje dany protokół...
 */

protocol Dummy {}

ProtocolsImplementer.self is TvAnchor.Type
ProtocolsImplementer.self is WeatherAnchor.Type
ProtocolsImplementer.self is InstanceCauntable.Type
ProtocolsImplementer.self is Dummy.Type

//: Typ **musi** zadeklarować, że implementuje dany protokół.
anchor is TvAnchor // 💡 usuń "PogodynkaTV" z definicji klasy "Implementuje"
anchor is WeatherAnchor

/*:
 Można skorzystać z operatora `as?` aby sprawdzić czy instancja jakiegoś typu (sam typ) implementuje protokół. Ponieważ operator zwraca optional to dalej pracujemy jak z każdym innym optional-em. Np. używając składni `if let` lub `map`.
 */
if let pog = anchor as? WeatherAnchor {
    pog.temperature
}

/*:
 To co się przytrafia czasem to potrzeba powiedzenia, że przetrzymujemy w kolekcji instancje jakiejś klasy, ale ta klasa implementuje konkretny protokół (lub kilka). Przy pisaniu aplikacji np. chcemy mieć kolekcje instancji `UIView`, które implementują protokół `XYZ`.
 
 Swift nie wspiera wielokrotnego dziedziczenia. Dlatego jeżeli jakaś klasa ma _super klasę_ to musi być ona wymieniona jako pierwsza. Dalej po przecinku można wymienić protokoły, które implementuje dany typ.
 
 */

protocol TestProtocol {}

class SuperClass {}

class JustClass: SuperClass, TestProtocol {}

/*:
 Samą kolekcje definjuje się przy użyciu kompozycji:
 */

let classThatImplementsProtocol: (SuperClass & TestProtocol) = JustClass()

let collection: [(SuperClass & TestProtocol)] = [JustClass(), JustClass()]

/*:
 # Jaki problem rozwiązują protokoły
 
 Protokoły pozwalają "odkleić" definicję od implementacji. Można powiedzieć też, że ukrywają implementujący typ za wspólnym interfejsem (protokołem).
 
 ## Dlaczego to jest dobre?
 
 Mając dobre abstrakcje możemy skupić się na problemie nie na detalach. Powiedzmy mamy protokół `Drivable`, który abstrahuje pomysł/możliwość prowadzenia pojazdu. Jednak pojazdy są różne, duże ciężarówki, małe rowerki, statki, samoloty. Nie chcemy się barć z detalami związanymi z tym jak się prowadzi dany pojazd. Wszystkie te pojazdy można ukryć za jedną abstrakcją.
 
 Kolejnym powodem jest to, że tworząc nowy typ możemy skonformować do protokołu i wszystkie algorytmy będą działać z nowo zdefiniowanym typem. Nawet można skonformować cudzy typ! Pozwala to na ponowne użycie kodu.
 
 Na deser zostały testy. Jeżeli jakiś typ (klasa, struktura) do działania potrzebuje jakiś zależności to dobrze jest aby _wstrzykiwać_ je właśnie ukryte za protokołem.
 
 > Nie jest to zasada, której trzeba ślepo przestrzegać! Protokoły nie są lekką abstrakcją (mają koszt ze sobą związany). Czasem zwykła funkcja lub value type w zupełności wystarczą!
 
 Takie podejście pozwala na napisanie mockowych iplemnetacji zależności i użycie ich w testach. Zyskujemy sposób na "udowodnienie", że nasz kod działa zgodnie z wymaganiami. A zestaw testów sprawia, że bez strachu można modyfikować aplikację.
 
 ## Jeszcze jedna rzecz
 
 Aby jakiś typ implementował dany protokół to **musi być to jawnie napisane**. Czyli musi wystąpić w liście "dziedziczenia".
 
 */

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
