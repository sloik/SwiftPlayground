//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## [Optional Chaining](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/OptionalChaining.html)

let pogoda: [String: (Int?, String?)?]
type(of: pogoda)

pogoda =
[
    "Białystok" : (tmperatura: 14, wilgotność: "70%"),
    "Warszawa"  : nil,
    "Suwałki"   : (temperatura: nil, wilgotność: "80%")
]

let klucz = "Białystok"

if let danePogodowe = pogoda[klucz] {
    type(of: danePogodowe)

    if let (temperatura, _) = danePogodowe {
        type(of: temperatura)

        if let temp = temperatura {
            type(of: temp)

            temp
        } else {
            "nie było temperatury"
        }
    } else {
        "nie było danych pogodowych"
    }
} else {
    "nie było takiego miasta w słowniku"
}

//: Wyciągając wartość ze słownika otrzymujemy __optional__. Dlatego potrzenujemy pierwszy __?__ aby zobaczyć czy coś tam istnieje. Jeżeli tak to wiemy, że to jest __opcjonalny tuplet__ a więc aby dobrać się do jego zawartości potrzebujemy kolejny __?__ .

if let temperatura = pogoda[klucz]??.0 {
    type(of: temperatura)
    temperatura
} else {
    "czegos zabrakło..."
}

//: Bardziej czytelny przykład

var pogodaGodz : [String: [Int: [String: String]]] =
[
    "Kraków" :   [12: [
        "temperatura": "12 stopni C",
        "wilgotnosc" : "80 %"
        ]
    ]
]
type(of: pogodaGodz)

let wilgotnoscGodz12 = pogodaGodz["Kraków"]?[12]?["wilgotnosc"]
type(of: wilgotnoscGodz12)
wilgotnoscGodz12

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
