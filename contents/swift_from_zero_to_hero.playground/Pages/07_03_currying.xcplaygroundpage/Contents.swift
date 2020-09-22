//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//: ## Currying / Rozwijanie Funkcji

import Foundation

//: Rozwijanie Funkcji to technika przy użyciu której jedna metoda zwraca inną ale z mniejszą ilością parametrów. Z czego ta "wewnętrzna metoda" ma dostęp do wszystkich wcześniej podanych parametrów.


func addToCartNormal(_ product: String, price: Double) -> (Int) -> String {

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

        return String(
            format: "Kupujesz \(count) razy \"\(product)\" każde po cenie %.2f co daje łącznie: %.2f",
            price * discountAmount,
            price * discountAmount * Double(count)
        )
    }

    return discountFunction
}

run ("📀 Golden Pants"){
    let itemToBuy = addToCartNormal("Złote Galoty", price: 100)
    print(
        itemToBuy(5)
    )
}


/*:
Wersja rozwinięta wygląda tak. Zwróć uwagę, że mamy tu funkcję, która zwraca funkcję, która zwraca funkcję ;) Logika jest ta sama ;)
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

            return String(format: "Kupujesz \(count) razy \"\(product)\" każde po cenie %.2f co daje łącznie: %.2f", price * discountAmount, price * discountAmount * Double(count))
        }
    }
}

let brownPantiesWaitingForPriceInformationFunction = addCurriedVersion("Brązowe Galoty")

/*:
`brownPanties...` ma w sobie zapieczoną informację o produkcie. Jest to bezpiecznie zamknięte wewnątrz bez możliwości podmiany tego produktu. W następnym kroku powiemy tej funkcji jaka jest cena za jedną sztukę produktu i w zamian otrzymamy kolejną funkcje!
 */

run ("💰 curry version") {
    let calculatePriceWithDiscountWaitingForItemsCount = brownPantiesWaitingForPriceInformationFunction(100)
    
    print(
        calculatePriceWithDiscountWaitingForItemsCount(1),
        calculatePriceWithDiscountWaitingForItemsCount(5),
        calculatePriceWithDiscountWaitingForItemsCount(15),
        calculatePriceWithDiscountWaitingForItemsCount(55),
        separator: "\n"
    )
}

/*:
 Dostajemy kolejny sposób na _enkapsulacje_, ukrywanie detali implementacyjnych.
 
 Curring jest obecny w wielu językach, szczególnie tych nastawionych na programowanie funkcyjne. Dzięki takiemu podejściu dużo łatwiej komponuje się ze sobą funkcje tworząc z mniejszych większe.
 
 Dogłębnie wchodzimy w ten temat na naszym YouTube-owym kanale w play-liście [Lekko Technologiczny - Funkcyjny Swift](https://www.youtube.com/playlist?list=PLk_5PV9LrXp-R6TM86MxqlihQSu_ZIhUk).
 */

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
