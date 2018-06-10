//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Quick start
/*:
> Playground - noun: a place where people can play
*/

import Foundation

let str = "Hello, playground"
NSLog(str)
print(str)
dump(str)

__

let str1 = "Lorem"; let str2 = "ipsum"
print(str1, str2)
print(str1, str2, separator: " -💩- ", terminator: "💥")

//: Playgrounds allow easy experimentation with Swift. Just type some code and it will be compiled and run. As a cool bonus result of those operations will be displayed "live" 👏🏻. One can also chose how to see those results dempending on their contents 🍰

for i in 0..<36 {
    sin(Double(i) * 100)
}

let range = 20
for x in -range...range {
    2*x*x*x + 40 // 2x^3 + 40
}

for i in 0..<8 {
    _ = sin(Double(i) * 100)
}

for i in 0..<8 {
    sin(Double(i) * 100)
}

//: If one want's to run the code again just hit **"play"** at the bottom of the editor or chose *"Editor -> Execute Playground"*.

for _ in 0..<50 {
    arc4random_uniform(50)
}

//: Domyślnie playgroundy automagicznie kompilują i uruchamiają wpisany kod dosłownie po każdej zmianie. Jest to dość wygodne natomiast może być irytujące (szczególnie gdy tego kodu trochę jest). Można wyłączyć ten tryb przez dłuższe wciśnięcie i przutrzymanie ikonki **"play"** służącej do ponownego uruchomienia *"placu zabaw"*.

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
