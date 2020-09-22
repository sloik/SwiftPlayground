//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
import Foundation

/*:
 ## Problem
 Często używamy jakiegoś konkretnego typu do reprezentowania czegoś zupełnie innego.
 
 Np.:
 */

let whoKnows = "1234"
let whatIsIt = "test@gmail.com"

/*:
 Powiedzmy, że mamy jakieś klasy, które spodziewają się że jako parametr otrzymają stringową reprezentację jakiś danych.
 */

struct EmailConsumer {
    func consume(email: String) throws {
        guard email.contains("@") else {
            throw NSError(domain: "not a email", code: 42)
        }
        
        print("Consumed email: \(email)")
    }
}

struct NumberConsumer {
    func consume(number: String) throws {
        guard let _ = Int(number) else {
            throw NSError(domain: "NaN", code: 24)
        }
        
        print("Consumed number: \(number)")
    }
}

let ec = EmailConsumer()
let nc = NumberConsumer()

do {
//    try ec.consume(email: whoKnows)
//    try ec.consume(email: whatIsIt)
//    try nc.consume(number: whoKnows)
//    try nc.consume(number: whatIsIt)

    throw NSError(domain: "Test Error", code: 69)
}
catch let err as NSError {
    err.debugDescription
}

/*:
Chcielibyśmy takie rzeczy wyłapywać w czasie kompilacji a nie w czasie działania aplikacji. Aby to zrobić musimy nieco podpowiedzieć czego się spodziewamy.
 
 ## Typ Fantomowy
 */

struct Phantom<Type> {
    let value: String
}

/*:
 Dodatkowo "określmy" z jakimi typami będziemy mieli do czynienia. Ponieważ zależy nam na tym aby dodatkowo anotować typy w czasie kompilacji a nie tworzyć ich instancję to użyjemy enumów.
 */

enum Email  {}
enum Number {}

let email  = Phantom<Email>(value: "jest@email.com")
let number = Phantom<Number>(value: "1234")


struct PhantomEmailConsumer {
    func consume(email: Phantom<Email>) throws {
        guard email.value.contains("@") else {
            throw NSError(domain: "not a email", code: 42)
        }
        
        print("Consumed email: \(email.value)")
    }
}

struct PhantomNumberConsumer {
    func consume(number: Phantom<Number>) throws {
        guard let num = Int(number.value) else {
            throw NSError(domain: "NaN", code: 24)
        }
        
        print("Consumed number: \(num)")
    }
}

do {
//    let pec = PhantomEmailConsumer()
//    let pnc = PhantomNumberConsumer()

//        try pec.consume(email: email)
//        try pnc.consume(number: number)

//        try pec.consume(email: number)
//        try pnc.consume(number: email)

    // Oczywiście zasada shit in shit out dalej obowiązuje ;)
//    let badEmail = Phantom<Email>(value: "not an e-mail")
//    let badNumber = Phantom<Number>(value: "not an number")
//    try pec.consume(email: badEmail)
//    try pnc.consume(number: badNumber)

    throw NSError(domain: "Test Error", code: 69)
}
catch let err as NSError {
    err.debugDescription
}

/*:
* [ObjC.io Phantom Types](https://www.objc.io/blog/2014/12/29/functional-snippet-13-phantom-types/)
* [Realm Academy](https://academy.realm.io/posts/swift-summit-johannes-weiss-the-type-system-is-your-friend/)
*/

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
