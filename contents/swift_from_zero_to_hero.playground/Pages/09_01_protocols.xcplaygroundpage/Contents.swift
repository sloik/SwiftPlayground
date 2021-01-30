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
        print("\(Self.instanceCounter)")
        return Self.instanceCounter
    }
}

class Implementuje: TvAnchor, InstanceCauntable {
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
        
        Implementuje.instanceCounter += 1
    }
    
    deinit {
        Implementuje.instanceCounter -= 1
    }
    
    func ustawWilgotnosc(_ nowaWilgotnosc: Int) {
        humidity = nowaWilgotnosc
    }
}



//: ### Przykłady :)

var pogodynka = Implementuje.init(nameOfAnchor: "Sandra")
pogodynka.weatherStatus()
pogodynka.ustawWilgotnosc(80)
pogodynka.weatherStatus()
Implementuje.liczbaInstancji()

do {
    Implementuje.init(nameOfAnchor: "Natalia") // 💡 żyje na stosie
    Implementuje.liczbaInstancji()
}

Implementuje.liczbaInstancji()

//: Tablica Obiektów Implementująca Protokoły

class Jakis: InstanceCauntable {
    static var instanceCounter: Int = 0
}

var implementujace: [WeatherAnchor & InstanceCauntable] = []
type(of: implementujace)

typealias SamoliczacaSiePogodynka = WeatherAnchor & InstanceCauntable
let samoliczaca: [SamoliczacaSiePogodynka] = []

type(of: implementujace) == type(of: samoliczaca)

implementujace.append(pogodynka)

let cosiek = Jakis()
Jakis.instanceCounter

//implementujace.append(cosiek) // 💥

implementujace

//: ## Delikatna Introspekcja
//: Czasami chcemy wiedzieć czy jakiś typ implementuje dany protokół...

Implementuje.self is TvAnchor
Implementuje.self is WeatherAnchor

//: Typ **musi** zadeklarować, że implementuje dany protokół.
pogodynka is TvAnchor // 💡 usuń "PogodynkaTV" z definicji klasy "Implementuje"
pogodynka is WeatherAnchor


if let pog = pogodynka as? WeatherAnchor {
    pog.temperature
}

//: Typ ktory jest klasą i konforumuje do protokołu
protocol TestowyProtocol {}
class WlasnaKlasa {}
class Podklasa: WlasnaKlasa, TestowyProtocol {}

let klasaImplementujacaProtokol: (WlasnaKlasa & TestowyProtocol) = Podklasa()

let kolekcja: [(WlasnaKlasa & TestowyProtocol)] = [Podklasa(), Podklasa()]

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
