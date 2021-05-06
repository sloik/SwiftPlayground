//: [Previous](@previous)

import Foundation

/*:
 
 # 🤑 Dziedziczenie
 
 ```
           ┌──────────────────┐
           │      Animal      │
           └──────────────────┘
                     ▲
                     │
           ┌──────────────────┐
           │      Mammal      │
           └──────────────────┘
               ▲           ▲
          ┌────┘           └──────┐
┌──────────────────┐    ┌──────────────────┐
│       Dog        │    │       Cat        │
└──────────────────┘    └──────────────────┘
 ```
 
 */

class Animal { func animalBehaviour() { print(#function, #line) } }
class Mammal: Animal { override func animalBehaviour() { print(#function, #line, "🍼") } }
class    Dog: Mammal { override func animalBehaviour() { print(#function, #line, "🐶") } }
class    Cat: Mammal { override func animalBehaviour() { print(#function, #line, "🐱") } }

let animal = Animal() ; let dog = Dog() ; let cat = Cat()

func doAnimalStuff(_ animal: Animal) { animal.animalBehaviour() }

doAnimalStuff(cat)
















































print("🤑")

//: [Next](@next)
