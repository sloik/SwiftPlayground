//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:## What's a Class, Struct, Enumeration

/*:
 ### [Klasy i Struktury](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html)

_Classes and structures are general-purpose, flexible constructs that become the building blocks of your program’s code. You define properties and methods to add functionality to your classes and structures by using exactly the same syntax as for constants, variables, and functions._

W gruncie rzeczy __Klasy__ oraz __Struktury__ są bardzo podobne do siebie:
* posiadają właściwości (properties) i mogą przechowywać wartości
* można w nich definiować metody
* można wzbogacić je w obsługiwanie subskryptu ([])
* mogą posiadać initializery 
* można je rozszerzać przy pomocy kategorii
* mogą implementować protokoły

Tylko klasy dodatkowo mogą:
* dziedziczyć po innej klasie (struktury tego nie mogą)
* są przekazywane przez referencje (struktury są kopiowane)
* deinitializery mogą istnieć tylko w klasach
* [wiecej w dokumentacji](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html)
*/
//: ## [Enumeracja](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145)
//: Są sposobem do grupowania powiązanych ze sobą wartości. W Swift natomiast są na sterydach i są pełnoprawnymi typami. Mogą też posiadać metody.

/*:
 ### Kiedy Używać Czego

Jak widać konkretny przypadek użycia będzie nam podpowiadać z czego powinniśmy skorzystać. Jeżeli potrzebujemy dziedziczenia lub przekazywania przez referencje to Klasa jest jedyną słuszną drogą. Apple zaleca aby zaczynać od Struktury i jeżeli to nie wystarczy dopiero wtedy robić Klasę.
*/

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
