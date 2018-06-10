//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## [Defer](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html#//apple_ref/doc/uid/TP40014097-CH42-ID514)

import Foundation

 do {
    defer {
        print("defer -> 1");
    }

    print("Hmmmm....")

    defer {
        print("defer -> 2");
    }

    print("A to ciekawe...")
}

print("")

//: Bardziej życiowy przykład...

enum CosWybuchlo: Error {
    case mialesPecha
}

func wybuchajaca() throws {
    print("\twybuchajaca(💥) -> ktoś bedzie mieć pecha ;)")
    throw CosWybuchlo.mialesPecha
}

func korzystajacaZWybuchajacej(_ maOhandlowac: Bool) throws {

    print("korzystajaca() -> otiweram ważny zasób lepiej aby na koniec był zamknięty")
    defer {
        print("korzystajaca(😎) -> zamykam ważny zasób")
    }

    print("korzystajaca() -> normalnie pracuje z waznym zasobem")

    if maOhandlowac == false {

        try wybuchajaca()
        print("korzystajaca() -> tu nie dojdziemy przy błędzie...")

    }
    else {
        do {
            try wybuchajaca()
        } catch {
            print("korzystająca() -> handluje z tym")
        }

        print("korzystajaca() -> jednak cos da sie tu dojsc...")
    }

    defer {
        print("korzystajaca(😎) -> ostatni gasi swiatlo")
    }
}

do {
   try korzystajacaZWybuchajacej(false)
} catch {
    print("cos wybuchlo")
}

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
