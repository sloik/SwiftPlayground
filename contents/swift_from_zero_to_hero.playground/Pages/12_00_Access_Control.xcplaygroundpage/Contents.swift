//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Access Control](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AccessControl.html)

/*:
W Swift modyfikatory dostępu występują na dwuch poziomach: pliku oraz modułu (target lub framework).

Wystepują trzy modyfikatory:
* **public** - Najszerszy ze wszystki świetnie się nadaje do definiowania API frameworków. Wszystkie symbole w ten sposób oznaczone są dostępne w całym module jak również można je importować w innych modułach.
* **internal** - **Domyślny dla Projektów Xcode**. Symbole są dostępne w całym projekcie natomiast nie mogą być zaimporotwane w innym pliku.
* **private** -**Domyślny dla Placu Zabaw**. Symbole są dostępne tylko **w pliku** w którym są zdefiniowane.
*/

private class KlasaSkryta {
    fileprivate class KlasaJeszczeSkrytsza {

    }
}

/*:
Jak widać poniżej możemy się _dobrać_ do klasy zdefiniowanej wewnątrz KlasySkrytej bez najmniejszego problemu! Nie jest to zachowanie, którego można by się było spodziewać dlatego powiem to jeszcze raz: **Modyfikatory Dostępu w Swift Działają Na Poziomie Pliku**
*/
class PoProstuKlasa {
    fileprivate var coTuSieWyrabia: KlasaSkryta.KlasaJeszczeSkrytsza? = nil
}

/*:
Ponieważ większość kodu jaki jest pisany ląduje zdecydownaie w projekcie Xcode to zapraszam do otworzenia **AccesControl** który się znajduje obok tego placu zawbaw.
*/

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
