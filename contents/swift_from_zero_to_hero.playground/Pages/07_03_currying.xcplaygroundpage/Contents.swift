//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Currying / Rozwijanie Funkcji

import Foundation

//: Rozwijanie Funkcji to technika przy użyciu której jedna metoda zwraca inna ale z mniejszą ilością parametrów. Z czego ta "wewnętrzna metoda" ma dostęp do wszystkich wcześniej podanych.


func addToCartNormal(_ product: String, price: Double) -> ((Int) -> String) {

    func discountFunction(_ count: Int) -> String {
        let discountAmount: Double

        switch count {
        case ...10:
            discountAmount = 1.0
        case 11...20:
            discountAmount = 0.9
        default:
            discountAmount = 0.8
        }

        return String(format: "Kupujesz \(count) razy \"\(product)\" każda po cenie %.2f co daje łącznie: %.2f", price * discountAmount, price * discountAmount * Double(count))
    }

    return discountFunction
}

let itemToBuy = addToCartNormal("Złote Galoty", price: 100)
print(itemToBuy(5))


/*:
Wersja rozwinięta wygląda tak. Zwróć uwagę, że mamy to funkcję, która zwraca funkcję, która zwraca funkcję ;) Logika jest ta sama ;)
 */
func addCurriedVersion(_ product: String) -> (Double) -> (Int) -> String {

    return { (price: Double) in

        return { (count: Int) -> String in

            let discountAmount: Double

            switch count {
            case ...10:
                discountAmount = 1.0
            case 11...20:
                discountAmount = 0.9
            default:
                discountAmount = 0.8
            }

            return String(format: "Kupujesz \(count) razy \"\(product)\" każda po cenie %.2f co daje łącznie: %.2f", price * discountAmount, price * discountAmount * Double(count))
        }
    }
}

let browPantiesWaitingForPriceInformationFunction = addCurriedVersion("Brązowe Galoty")

/*:
`browPanties...` ma w sobie zapieczoną informację o produkcie. Jest to bezpiecznie zamknięte wewnątrz bez możliwości podmiany tego produktu. W następnym kroku powiemy tej funkcji jaka jest cena za jedną sztukę produktu i w zamian otrzymamy kolejną funkcje!
 */

let calculatePriceWithDiscountWaitingForItemsCount = browPantiesWaitingForPriceInformationFunction(100)

print(
    "-",
    calculatePriceWithDiscountWaitingForItemsCount(1),
    calculatePriceWithDiscountWaitingForItemsCount(5),
    calculatePriceWithDiscountWaitingForItemsCount(15),
    calculatePriceWithDiscountWaitingForItemsCount(55),
    separator: "\n"
)


//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
