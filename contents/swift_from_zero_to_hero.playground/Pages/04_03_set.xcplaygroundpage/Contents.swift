//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Set
/*:
* [🇵🇱 Swift od zera do bohatera! Set Zbiór - Tworzenie i podstawowe operacje](https://www.youtube.com/watch?v=yg-I0LuEDiI&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=10)
 
 * [🇵🇱 Swift od zera do bohatera! Set Zbiór - Operacje i Modyfikacja](https://www.youtube.com/watch?v=OpobYWEbVJY&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=11)
*/
//: ## Tworzenie
var emoji = ["💩", "⚡️", "😎"]
type(of: emoji)

var setEmoji : Set = ["💩", "⚡️", "😎"] // magia! //ExpressibleByArrayLiteral
type(of: setEmoji)

var setStringow: Set = ["Lorem", "Ipsum"]

var pustySetStringow : Set<String> = []
type(of: pustySetStringow)

var pustySetIntow = Set<Int>()
type(of: pustySetIntow)

//: Tworząc `Set` przy użyciu tablicy wszelkie duplikaty zostaną z niej usunięte.
var tylkoRaz: Set = ["💩", "⚡️", "😎", "💩", "⚡️", "😎"]

//: ## Inspekcja
setEmoji
setEmoji.count
setEmoji.isEmpty
setEmoji.contains("💩")

let podset: Set = ["⚡️", "😎"]
podset.isSubset(of: setEmoji)
podset.isStrictSubset(of: setEmoji)
podset.isSubset(of: emoji) // array

podset.isStrictSubset(of: emoji)
podset.isStrictSubset(of: podset)

setEmoji
setEmoji.isSubset(of: setEmoji)
setEmoji.isStrictSubset(of: setEmoji)

//setStringow.insert("💩")
setStringow
setEmoji
setEmoji.isDisjoint(with: setStringow)

//: ## Operacje Na Setach

let zestaw1: Set = ["💩", "⚡️", "😎"]
let zestaw2: Set = ["💩", "🍻", "👏🏻"]

let alternatywaWykluczajaca = zestaw1.symmetricDifference(zestaw2)
let przeciecie = zestaw1.intersection(zestaw2)
let suma       = zestaw1.union(zestaw2)
let roznica    = zestaw1.subtracting(zestaw2)

//: ## Modyfikacja
var doModyfikacji: Set = ["💩", "⚡️", "😎"]

doModyfikacji.insert("🍻")
doModyfikacji.insert("🍻")

let piwko = doModyfikacji.remove("🍻")
type(of: piwko)
doModyfikacji.remove("🍻")

let indexKupki = doModyfikacji.firstIndex(of: "💩")
type(of: indexKupki)

doModyfikacji.remove(at: indexKupki!)

//: ## Zagnieżdzenie

let setStringow1: Set = ["💩", "⚡️", "😎"]
let setStringow2: Set = ["Lorem", "Ipsum", "Sit"]
let setLiczb: Set = [1, 2, 3]

let setSetowStringow: Set = [setStringow1, setStringow2]
type(of: setSetowStringow)

//let mieszany: Set<Any> = [setStringow1, setLiczb] // 💥

print("🍀")
//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
