//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)

import UIKit
//:# UI Trait Collection
//:> "trait" - ang. cecha
/*:
 A trait collection describes the iOS interface environment for your app, including traits such as horizontal and vertical size class, display scale, and user interface idiom. **To create an adaptive interface, write code to adjust your app’s layout according to changes in these traits.**
 
 ## Krótka Historia Czasu... tak jakby
 Na początku świat był bardzo prosty. Posiadał jeden wymiar, jedeną rozdzielczość a kciuk sięgał tam gdzie trzeba było bez potrzeby małpiej zręczności. Wyglądało to mniej więcej tak:
 
 ![Pierwszy iPhone](1st_iphone.jpg)
 
 UI (czyt. ju aj a nie uj) tworzyło się bardzo łatwo i można było śmiać się z Androida, że ma tyle ekranów. I to było dobre 🍰 Jednak jak wiemy ludzkość zawsze dąży do następnej i z czasem pojawiła się kolejna rozdzielczość do obsłużenia.
 
 ![Pierwszy iPad](apple-ipad-1st-generation.jpg)
 
 Tragedii jeszcze nie było. Przecież to jest tylko dodatkowe urządzenie ekstra z jedną rozdzielczością. Doliczając różne orientacje to i tak daje **tylko 4** kombinacje. W dalszym ciągu można było się śmiać z Androida, że ma tyle ekranów. I to było dobre 🍰
 
 Jednak jak wiemy taki stan rzeczy nie mógł pozostać na długo. Na skutek GMO i hormonów wzrostu dodawnych do pożywienia u ludzkości wykształciły się dłuższe kciuki. To pociągneło za sobą falę kolejnych urządzeń z różnymi rozmiarami a nawet z różną gęstością pikseli na ektanie! Do tego ktoś wpadł na pomysł, żeby uruchomić na urządzeniu mobilnym więcej jak jedną aplikację na raz. Piekło po prostu zamarzło 😵 No i nie można już było się śmiać z Androida 😢
 
 Dziś ten świat wygląda mniej więcej tak:
 
 ![size classes](size_classes_2x.png)
 ![multitasking](multitasking-size-classes_2x.png)
 
 > Co łatwo przegapić z ostatniej grafiki to fakt, że nie możemy już polegać tylko na tym jak szeroki mamy ekran aby określić na jakim urządzeniu jest uruchomiona aplikacja.
 
 
 Tworzenie ładnych i adaptujących się do używanego kontekstu UI stało się nieco trudniejsze. Na całe szczęście nie jesteśmy pozostawieni całkiem sami sobie. Do pomocy przychodzi właśnie **TraitCollection**.
 
 ---
 ## Czego można się dowiedzieć z takiej kolekcji cech?
 W raz z powiekszaniem się ekosystemu urządzeń i ich cech klasa zyskiwała dodatkowe pola. Najświeże informacje jak zwykle w dokumentacji natomiast w dniu dzisiejszym kolekcja posiada informacje o następujących cechach:
 * display scale (gęstość pikseli urządzenia)
 * horizontal size class
 * vertical size class
 * user interface idiom (unspecified, phone, pad, tv, car play)
 * force touch
 
 Oczywiście można się spodziewać kolejnych cech w miare jak będą się zmieniać możliwości urządzeń.
 
 ---
 ## Przykłady
 */

//: ### Tworzenie
var deviceTrait = UITraitCollection(userInterfaceIdiom: .carPlay)
deviceTrait.description

var horizontalTrait = UITraitCollection(horizontalSizeClass: .regular)
horizontalTrait.description

var verticalTrait = UITraitCollection(verticalSizeClass: .compact)
verticalTrait.description

var forceTrait = UITraitCollection(forceTouchCapability: .available)
forceTrait.description

var scaleTrait = UITraitCollection(displayScale: 6.9)
scaleTrait.description

var gamutTrait = UITraitCollection(displayGamut: .P3)
gamutTrait.description

var oneToHaveThemAllTrait = UITraitCollection(traitsFrom: [deviceTrait, horizontalTrait, verticalTrait])
oneToHaveThemAllTrait.description

//: ### Porównania
oneToHaveThemAllTrait.containsTraits(in: horizontalTrait)
oneToHaveThemAllTrait.containsTraits(in: gamutTrait)
//: Niestety prosto z pudełka nie możemy sprawdzić kilku cech na raz. Musimy do tego utworzyć pomocniczą kolekcje.
let workingTrait1 = UITraitCollection(traitsFrom: [horizontalTrait, gamutTrait])
workingTrait1.description
oneToHaveThemAllTrait.containsTraits(in: workingTrait1)

let workingTrait2 = UITraitCollection(traitsFrom: [horizontalTrait, deviceTrait])
workingTrait2.description
oneToHaveThemAllTrait.containsTraits(in: workingTrait2)
//: Mozna sie pokusic o małą szpachle...
private typealias LittleSzpachla = UITraitCollection
fileprivate extension LittleSzpachla {
    func containsTraits(in inTraits: [UITraitCollection]) -> Bool {
        let working = UITraitCollection(traitsFrom: inTraits)
        
        return self.containsTraits(in: working)
    }
}

oneToHaveThemAllTrait.containsTraits(in: [horizontalTrait, gamutTrait])
oneToHaveThemAllTrait.containsTraits(in: [horizontalTrait, deviceTrait])

/*:
 ## The End... tak jakby
 Zrozumienie tej klasy i funkcjonalności jaką zapewnia to tylko początek na drodze do zrozumienia i tworzenia w pełni adaptujących się interfejsów uzytkownika.
 
 Na dalszą drogę polecam:
 
 * [UITraitEnvironment Protocol](https://developer.apple.com/reference/uikit/uitraitenvironment)
 * [traitCollectionDidChange](https://developer.apple.com/reference/uikit/uitraitenvironment/1623516-traitcollectiondidchange)
 * [setOverrideTraitCollection(_:forChildViewController:)](https://developer.apple.com/reference/uikit/uiviewcontroller/1621406-setoverridetraitcollection)
 * [WWDC 2014 Sesja 216 Building Adaptive Apps with UIKit](https://developer.apple.com/videos/play/wwdc2014/216/)
 
 */

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)

