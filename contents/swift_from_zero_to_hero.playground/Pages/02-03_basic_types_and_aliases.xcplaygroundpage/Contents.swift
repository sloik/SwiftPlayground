//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Basic Types and Aliases

import Foundation

//: ## Definiowanie Stringow
var str = "Witaj placu zabaw!"
type(of: str)

var string: String = "Tym razem zmienna z podanym typem"

//: ## Definiowanie Znakow
let znak = "a"
type(of: znak)

let znak1 : Character = "a"
type(of: znak1)

let znak2 = "a" as Character
type(of: znak2)

let uUmlaut          : Character = "\u{75}\u{308}"
let uUmlautPolaczone : Character = "\u{FC}"

//: ## Definiowanie Liczb Całkowitych
/*:
* **Ze znakiem**: `Int`, `Int8`, `Int16`, `Int32`, `Int64`
* **Bez znaku**: `UInt`, `UInt8`, `UInt16`, `UInt32`, `UInt64`
* `Int` na 32-bit platformach: +/- 2.14 miliarda
* `Int` na 64-bit platformach: +/- 9 kwintylionów (9 i osiemnaście zer 😮)
*/
//: Domyslnie wszystkie liczby całkowite są ze znakiem
let calkowita = -1_000_000_000
type(of: calkowita)

let calkowita1 = 1_000_000_000
type(of: calkowita)

let calkowitaBezZnaku : UInt = 1_000_000_000
type(of: calkowitaBezZnaku)

//: ## Definiowanie Liczb Zmiennoprzecinkowych
/*:
* `Float` : ~ 6  (dokładność do około  6 miejsc po przecinku)
* `Double`: ~ 15 (dokładność do około 15 miejsc po przecinku)
*/

let zmiennoPrzeciwnkowa = 3.14
type(of: zmiennoPrzeciwnkowa)

let zmiennoPrzecinkowa1: Float = 3.14
type(of: zmiennoPrzecinkowa1)

let calkowita3 = 3
type(of: calkowita)

let zmiennoPrzecinkowa2 = 3 as Double
type(of: zmiennoPrzecinkowa2)

//zmiennoPrzeciwnkowa * zmiennoPrzecinkowa1 * calkowita3 // 💥
zmiennoPrzeciwnkowa * Double(zmiennoPrzecinkowa1) * Double(calkowita3)

//: ## Definiowanie zmienny Booloskich
let gownoPrawdaToTezPrawda = true
type(of: gownoPrawdaToTezPrawda)

let czarneJestBialeABialeJestCzarne: Bool = false
type(of: czarneJestBialeABialeJestCzarne)

//: ## Literały Numeryczne
let binarny  = 0b10000 // b - binary
type(of: binarny)

let osemkowy = 0o20    // o - octal
type(of: osemkowy)

let oct = 0o20 * 0.5 
type(of: oct)

let hex      = 0x10    // x - heXadicemal
let naukowy  = 1.6e2   // 1.6 * 10^2

//: ## Aliasy

typealias AliasNaUInt = UInt

let calkowita4    = AliasNaUInt.max // alias jest inaczej kolorowany
let innaCalkowita = UInt.max

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
