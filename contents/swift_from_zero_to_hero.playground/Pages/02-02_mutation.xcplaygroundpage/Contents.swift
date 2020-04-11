//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Mutation
/*:
 * [🇵🇱 Swift od zera do bohatera! No co za Typ - System Typów w Swift](https://www.youtube.com/watch?v=THFkeVjfGeo&list=PLk_5PV9LrXp-5ImtHWeIsabWhBELxYNsu&index=4)
*/
/*:
Dla kogoś kto przybył ze swiata Objective C mutowalność (czy też to czy dany obiekt może się zmieniać czy nie) jest powiązana z parami klas np. NAArray i NSMutableArray. W Swifcie jest dużo prościej. To czy coś jest zmienne czy nie zależy tylko od tego czy zostało zadeklaorowane przy użyciu słowa **_let_** czy **_var_**.
*/

import Foundation

var przywitanie = "Witaj placu zabaw!"
przywitanie = "Witaj swiecie"

let thereBe = "💡"
//: Po odkomentowaniu kodu niżej w konsoli pojawi się komunikat
//:> error: cannot assign to value: 'thereBe' is a 'let' constant thereBe = "💥" ...: note: change 'let' to 'var' to make it mutable
// thereBe = "💥"

var tablica = ["💡", "💥"]
tablica.append("🍰")

let coSieStaloToSieNieOdstnie = ["💡", "💥"]
//: Ponownie kompilacja się nie uda
//:> error: cannot use mutating member on immutable value: 'coSieStaloToSieNieOdstnie' is a 'let' constant coSieStaloToSieNieOdstnie.append("🍰") ... note: change 'let' to 'var' to make it mutable
//coSieStaloToSieNieOdstnie.append("🍰")

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
