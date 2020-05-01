//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Switch / If Case oraz For Case / Optional binding / Optional Pattern Matching
import Foundation

/*:
Aby nieco uatrakcyjnić przykłady przygotujemy sobie scenę. Użyjemy do tego wszystkiego czego się nauczyliśmy do tej pory.
 
 Aby łatwiej się rozmawiało zadaniu z jakim się będziemy mierzyć utworzymy aliasy na już istniejące typy. Dzięki temu zamiast mówić o Stringa i Intach (szczegóły implementacyjne) będziemy rozmawiać o Punktach i Kościach.
 
 Od teraz w miarę możliwości wszystkie nazwy będziemy nadawać po angielsku. Jak do szkolnych przykładów to nie uważam, że jest to wielki błąd aby _kod_ był pisany po polsku. Tak w pracy na 99% spotkacie się z wymaganiem, że musi być po angielsku.
 */

typealias Points = Int
typealias Dice   = String

/*:
 Potrzebujemy teraz jakoś zasymulować naszą grę. Zaczniemy od określenia tego jak nasze kości wyglądają i ile punktów jest warta każda z nich.
 */
let dices: [Dice: Points] = ["⚀": 1, "⚁": 2, "⚂": 3, "⚃": 4, "⚄": 5, "⚅": 6]


/*:
 Od jakiegoś czasu Swift pozwala nam na _wyciągnięcie_ losowego elementu z kolekcji. Przy pomocy tej metody będziemy symulować **rzut kością**.
 */
var rollOne: Dice = dices.randomElement()!.key
var rollTwo: Dice = dices.randomElement()!.key



/*:
 Komputer jeszcze nie potrafi spojrzeć na kostkę i powiedzieć ile punktów należy przyznać za dany rzut. Musimy zrobić to sami.
 */
dices[rollOne]
dices[rollTwo]

run("🎲 wartości kostek") {
    print("Rzut \(rollOne) jest wart: \(String(describing: dices[rollOne]))")
    print("Rzut \(rollTwo) jest wart: \(String(describing: dices[rollTwo]))")
}

/*:
 Widać, że potrafimy się dobrać do punktów, ale są one owinięte w Optional. Możemy dodawać `!` przy każdym sprawdzeniu, ale to sprawi że przykłady staną się mniej czytelne. Dlatego zastosuje tu małą _sztuczkę_, która do celów edukacyjnych powinna być ok.
 
Otworzymy sobie Typ Dictionary i dodamy do niego metode która sprawi, że API będzie nam lepiej mówiło o intencji użycia. O samych _extension_-ach (tak się ten mechanizm nazywa) opowiemy osobno.
 */

extension Dictionary {
    func points(for key: Key) -> Value { self[key]! }
}

/*:
Nie było tak strasznie. Zobaczmy w akcji tą metodę.
 */

dices.points(for: rollOne)
dices.points(for: rollTwo)

/*:
 Tak więc mamy fajne API z którego możemy korzystać. Oczywiście jak zapytamy o coś czego nie ma w słowniku to nam coś takiego wybuchnie. Po prostu wiemy co robimy gdy biegamy z nożyczkami ✂️🏃🏼‍♀️
 
 ---
 ## Część właściwa
 
 Poznamy teraz instrukcje `if`, która trafiła do wojska. Spotkała tam _pattern matching_ i ostro przykoksiła. Acha jest coś co w przyszłości się na pewno przyda bo składnia nie jest tak intuicyjna i w pracy dosyć często trzeba ją sobie przypomnieć: [fucking if case let syntax](http://fuckingifcaseletsyntax.com)
 
 # Switch
 
 Instrukcja _switch_ to jest właśnie if na sterydach. Szczególnie gdy wykorzystamy jeszcze w niej _patter matching_. A cóż to takiego? W kilku słowach jest to mechanizm umożliwiający stworzenie szablonu/wzorca do którego potem jest przyrównywana jakaś wartość. Jeżeli szablon i wartość pasują to ta ścieżka w kodzie zostanie wybrana.
 
## Switch podstawa
 */

let meaningOfLife = 51

run("🎚 proste przykłady") {
    
    if meaningOfLife == 10 {
        print("Było 10")
    } else if meaningOfLife == 42 {
        print("Sensem życia jest liczba...")
    } else if meaningOfLife < 50 {
        print("Nie tak dużo")
    } else {
        print("Nic nie jest w życiu pewne.")
    }
}

/*:
 W zależności od tego co mamy ustawione jako stała `meaningOfLife` taką ścieżką pobiegnie program. Jednak jest bardzo dużo szumu z wieloma instrukcjami `if else`. Switch może coś takiego uprościć
 */

run("🎛 switch") {
    switch meaningOfLife {
    case 10:
        print("Było 10")
        
    case 42:
        print("Sensem życia jest liczba...")
        
    case _ where meaningOfLife < 50:
        print("Nie tak dużo")
        
    default:
        print("Nic nie jest w życiu pewne.")
    }
}

/*:
 Mamy tu wszystko. Krew, romans, łzy. Natomiast też jasno widać jaka ścieżka będzie wybrana. Możemy podać jako wzorzec/szablon/pattern konkretne wartości. Możemy też użyć predykatu (prawda lub fałsz). Do tego kompilator używa swojej wiedzy o typach aby wymusić obsłużenie każdego możliwego przypadku!
 
 Ten wzorzec nie musi się składać z jednej wartości. Może z wielu. My mamy teraz wyrzucone dwie kości. Czas podliczyć punky według następujących zasad:
 
 * ⚀ ⚀   = 30 punktów
 * ⚅ ⚅   = 30 punktów
 * ⚀⚁ ⚀⚁ = 16 punktów
 * suma oczek == 7 to 5 punktów
 * takie same kości i wartość oczek x2 da 4 lub 10 8 punktów w przeciwnym wypadki 10 punktów
 * suma oczek = sumie punktów
 
 */


switch (rollOne, rollTwo) {

case ("⚀", "⚀"): // (1, 1)
    fallthrough

case ("⚅", "⚅"): // (6, 6)
    "30 punktów"

case ("⚀"..."⚁", "⚀"..."⚁"): // (1...2, 1...2)
    "16 punktów"

    // rollOnePoints + rollTwoPoints == 7
case _ where dices.points(for: rollOne) + dices.points(for: rollTwo) == 7:
    "5 punktów"

    // rollOnePoints == rollTwoPoints
case (_, _) where rollOne == rollTwo:
    let dicePoints = dices.points(for: rollTwo)

    switch dicePoints * 2 {
    case 4, 10:
        "8 punktów"
    default:
        "10 punktów"
    }

default: // musi być ostatnie
    let rollOnePoints = dices.points(for: rollOne)
    let rollTwoPoints = dices.points(for: rollTwo)

    "\(rollOnePoints + rollTwoPoints) punktów"
}

/*:
 Wzorce są porównywane od góry do dołu. Tak więc jeżeli jakiś `case` będzie pasować wcześniej od innego to zostanie wykonany jako pierwszy. Jest to identyczne zachowanie jak `if else`. Tak więc warto na samej górze dawać jak najbardziej szczegółowe. A im niżej tym bardziej ogólne.
 
 Przypadek dla `default` można pominąć jeżeli kompilator może wyinferować, że wszystkie ścieżki są obsłużone.
 
 Jest jedna różnica w Swift w porównaniu do innych języków (szczególnie do C a co za tym idzie i do Objective-C). Ścieżka wykonania kodu w instrukcji switch zatrzymuje się na ostatniej linijce `case`a i potem _wychodzi_ z całej instrukcji. W innych językach przeszło by do następnego _przypadku_.
 
 
 Można też __switchować__ po klasach. Mając trzy dowolne typy:
 */

class ClassOne {}
class ClassTwo { var number = 42 }
class ClassSix { var index  = 24 }


var instance: AnyObject = ClassSix()

switch instance {

//: __podłoga__ jeżeli nie potrzebuje odwołać się do zmiennej
case _ as ClassOne:
    "pierwsza"

case let typ as ClassTwo:
    type(of: typ)
    typ.number

case let typ as ClassSix:
    typ.index
    typ.index = 69
    typ.index

default:
    break
}

instance.description

/*:
 ### If Case oraz For Case
 
 Trochę wybiegniemy w przyszłość i przedstawię tu enumerację. Dokładniej nad nimi będziemy się znęcać kiedyś tam. Jednak liczę na to, że za jakiś czas będziesz mieć już tę wiedzę i bardziej Tobie się przyda przykład jak tą pieprzoną składnie if case let opędzić.

 Jeżeli widzisz enumeracje pierwszy raz to... jest to sposób za zapisanie zbioru określonych wartości. Dni tygodnia są znane i jest ich 7 i raczej za prędko się to nie zmieni. Dlatego można użyć do tego właśnie enuma gdzie definiujemy możliwe wartości na samym początku. Do tego z tą wartością (case) może być powiązana inna wartość lub tuplet wartości. Całość daje bardzo dużo możliwości.
 
 My tu nie będziemy skakać na głęboką wodę ale się zanurzymy po pas. Nasza tajemnicza wartość może _być_ całkowitą liczbą (i mieć w sobie informacje o konkretnej wartości), ułamkiem oraz textem.
 */

enum Mistery {
    case whole(Int)
    case fraction(Double)
    case text(String)
}

/*:
 Tworząc instancje tego typu nie wiem z czym _konkretnie_ pracuje (liczba, ułamek, text).
 */
let misteryInstancje: Mistery = Mistery.whole(42)

/*:
 W sytuacji gdy chcemy coś zrobić z samą stałą/zmienną możemy wykorzystać __switch__
 */

switch misteryInstancje {
case .whole(let value):
    "Hura dla całkowitej \(value)"
case .fraction:
    break
case .text:
    break
}

/*:
 Widać, że reszta przypadków nas nie interesuje. I fajnie by było aby ten kod nie był taki _głośny_. Interesuje nas jeden _case_ a reszta to szum. Można też nieco to skrócić i zapisać tak:
 */

switch misteryInstancje {
case .whole(let value):
    "Hura dla całkowitej \(value)"

default:
    break
}

/*:
 Lepiej ale w dalszym ciągu bardziej hałaśliwe niż zwykły `if`...
 
### if case

 Całe szczęście jest sposób aby sprawdzić czy to właśnie z ta wartość co nas interesuje. Składnia to taki melanż instrukcji 'if' i ciała 'switch'. Impreza taka, że ciesz się że nie szczekasz.
 */

if case .whole(let value) = misteryInstancje {
     "Hura dla całkowitej \(value)"
}

/*:
Pracujemy z tym jak ze zwykłym if-em, więc wszstkie szczuczki dozwolone:
 */
if case .whole(let value) = misteryInstancje , value > 40 {
    "Hura dla całkowitej \(value)"
}

/*:
 ### for case
 
 Co w sytuacji gdy do obsłużenia jest cała kolekcja takich typów i chcemy z niej wyciągnąć zawarte rzeczy?
 */
let mysteries: [Mistery] = [.whole(42), .fraction(6.9), .text("sto"), .whole(69)]

/*:
 Wersja hałaśliwa może wyglądać tak:
 */
for mistery in mysteries {
    switch mistery {
    case .whole(let value):
        print("🌶", #line, "Hura dla całkowitej \(value)")
    default:
        break
    }
}

/*:
 lub:
 */

for mistery in mysteries {
    if case .whole(let value) = mistery {
        print("🎯", #line, "Hura dla całkowitej \(value)")
    }
}

/*:
 Możemy jednak zrobić jeszcze troszeczkę lepiej i przenieśc `if`-a _do_ `for`-a.
 */

for case .whole(let value) in mysteries {
    print("🐕", #line, "Hura dla całkowitej \(value)")
}

/*:
Podobnie jak wcześniej możemy dodatkowo zacieśniać zakres który nas interesuje przy pomocy słowa kluczowego __where__
 */
for case .whole(let value) in mysteries where value < 69 {
    print("👀", #line, "Hura dla całkowitej \(value)")
}

/*:
 ### Optional binding
 
 Optional-e już widzieliśmy. Po prostu mówią nam czy jakaś wartość jest obecna czy nie. Co więcej są zaimplementowane jako enum z dwoma `case`-ami `some` oraz `none`. Często chcemy coś zrobić właśnie z tą wartością co jest w środku.
 */
let voltage: Int? = 40

/*:
 Długa droga może wyglądać tak:
 */

switch voltage {
case .none:
    print("🏐", #line, "Z pustego to i Salomon nie naleje")
    
case .some:
    print("🏐", #line, "Coś tu mam. Mogę odpakować bezpiecznie wykrzyknikiem", voltage!)
}

/*:
 Bezpiecznie ale hałaśliwie. Jest składnia, która pozwala dobrać się do wartości wewnątrz Optional-a gdy tam jest. Nadajemy stałej nazwę i ona jest "bidowana" do tej wartości. Jak zobaczysz przykład to wyraz **bind** powinien stać się mniej obcy.
 */

switch voltage {
case .none:
    print("🦋", #line, "Z pustego to i Salomon nie naleje")
    
case .some(let bindedValue):
    print("🦋", #line, "Coś tu mam:", bindedValue)
}

/*:
 Zrobimy to samo co wcześniej czyli przejdziemy na zapis z `if`-em. Nazwa **percent** będzie zawierać w sobie _wartość_ jeżeli Optional nie jest `none` lub częściej jak się mówi _nie jest nil-em_.
 */

if let percent = voltage , percent >= 34 {
    print("🐝", #line, "Można pić bez obawień")
}


/*:

 Tu możemy się już zatrzymać. Dalsza część jest dla chętnych i raczej ciekawostka niż rzecz z jaką można się spotkać w pracy.
 
 ---

 #### [Optional pattern matching](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Patterns.html#//apple_ref/doc/uid/TP40014097-CH36-ID520)
 
 */

if case let bindedPercent = voltage {
    print("🐙", #line, bindedPercent as Any, type(of: bindedPercent))
}

if case let bindedPercent? = voltage , bindedPercent >= 34 { // bez '?` będzie Int?
    print("🦜", #line, bindedPercent, type(of: bindedPercent))
    type(of: bindedPercent)
}

let percents: [Int?] = [42, nil, 5, nil, 12]

for case let bindedPercent? in percents where bindedPercent > 5 {
    print("☄️", #line, bindedPercent, type(of: bindedPercent))
}

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
