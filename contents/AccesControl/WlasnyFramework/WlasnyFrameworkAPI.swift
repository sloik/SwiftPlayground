
import Foundation

// Wszystko co jest zadeklarowane jako publiczne będzie dostępne z innych modułów. 
// Wszystko co jest zadeklarowane jako prywatne nie będzie dostępne z innych modułów 
// natomiast jest dostępne z tego samego pliku.

// ⚡️: Identyczne deklaracje występują w projekcie aplikacji
private let losowaLiczba = 4
public  let cytat        = "Można pić bez obawień"

public class FrameworkowaKlasa {
    let imie = "Sandra" // domyślnie internal (widoczne tylko w module definiującym)

    // Jeżeli nie zostanie zadeklarowany to zostanie utworzony domyślny,
    // którego modyfikatorem dostępu będzie __internal__
    public init () {}
}

public struct FrameworkowaStruktura {
    public init() {}
}

extension FrameworkowaStruktura { // domyślnie __internal__
    var madroscNaDzien: String {
        return "Kto rano wstaje temu Pan Bóg daje."
    }

    public var madroscNaWieki: String {
        return "Zakręcaj weki!"
    }
}

public extension FrameworkowaStruktura { // domyślnie __internal__
    var madroscNaJutro: String {
        return "Jutro będzie futro."
    }
}

public typealias FStruktura = FrameworkowaStruktura // 💡 zmień public na internal

// Wszystkie CASEy mają ten sam modyfikator dostępu który występuje przy definicji. 
// Mogą natomiast mieć bardziej "swobodny".
public enum FrameworkowyEnum {
    case Pierwszy
    case Drugi(FStruktura)
}
