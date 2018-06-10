//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Unicode

import Foundation
/*: 
Każdy unicodowy znaczek jest 21 bitową liczbą.

[Swift Programming Language -- Unicode](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID293)
*/

let uUmlaut          : Character = "\u{75}\u{308}"
let uUmlautPolaczone : Character = "\u{FC}"

uUmlaut == uUmlautPolaczone

let znak         : Character = "\u{61}"
let modyfikator  : Character = "\u{301}"
let modyfikator2 : Character = "\u{20DD}"

let znakModyfikator             : Character = "\u{61}\u{301}"
let znakModyfikatorModyfikator2 : Character = "\u{61}\u{301}\u{20DD}"

let znak2 = "\u{E1}"
let znak2Modyfikator: Character = "\u{E1}\u{20DD}"

znak2Modyfikator == znakModyfikatorModyfikator2

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
