
import Foundation

private let randomNumber = 42
public  let quote        = "Można pić bez obawień -- Wiesław Wszywka"

private struct WeatherAnchor {
    var name: String // 💡 przy strukturze oznaczonej jako private oznacz zmienna jako public
}

class ApplicationClass { // domyślnie internal gdy nie ma żadnego

    /// ("private", "public")
    let tupleOfPrivatePublic = (randomNumber, quote)

    private var password: String { "Wiem ale nie powiem!" }

    fileprivate func performAction() { print("🐶 Łof łof") }
}

class InheritingAppClass: ApplicationClass {

    /// Overridden methods and properties can extend
    /// access modifiers.
    var password: String { "Żyrafy wchodzą do szafy" }

    override func performAction() { super.performAction() }
}

private protocol TitleProvider {
    var title: String { get }
}

struct ProtocolImplementer: TitleProvider {
    let title = "Podaje tytuł"
}
