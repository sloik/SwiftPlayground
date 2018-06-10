import Foundation

// ⚡️: Identyczne deklaracje występują we Frameworku
private let losowaLiczba = 42
public  let cytat        = "Można pić bez obawień -- Wiesław Wszywka"


private struct Pogodynka {
    var imie: String // 💡 przy strukturze oznaczonej jako private oznacz zmienna jako public
}

class WlasnaKlasa { // domyślnie internal gdy nie ma żadnego

    let cosiek = (losowaLiczba, cytat) // ("private", "public")

    private var haslo: String {
        return "Wiem ale nie powiem!"
    }

    fileprivate func dajGlos() {
        print("🐶 Łof łof")
    }
}

class Dziedziczka: WlasnaKlasa {

    // Nadpisane metody i właściwości mogą zmienić modyfikator dostępu.
    var haslo: String { return "Żyrafy wchodzą do szafy" }

    override func dajGlos() {
        super.dajGlos()
    }
}

private protocol Tytulowalna {
    var tytulSzlachecki: String { get } // 💡: spróbuj dodać modyfikator public do deklaracji
}

struct WynioslaPogodynka: Tytulowalna {
    let tytulSzlachecki = "Baron Poniemiecki"
}

