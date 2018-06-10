import UIKit
import WlasnyFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Mogę stworzyć instancje "WlasnejKlasy" i to bez importu ponieważ domyślnie
        // modyfikator dostępu tej klasy to "internal". Czyli widoczny w całym module.
        let mojeWlasne = WlasnaKlasa()

        // Ponieważ ta właściwość jest zadeklarowana jako private to nie mogę się
        // do niej odwołać z innego pliku.
//        mojeWlasne.haslo // 💥


        let dziedziczka = Dziedziczka()
        print(dziedziczka.haslo)
        dziedziczka.dajGlos()


        // Co gdy chcemy odwołać się do stałej "cosiek", która jest krotką stworzoną
        // ze stałej prywatnej i publicznej.

        let pierwszaWartosc = mojeWlasne.cosiek.0 // ⚡️
        let drugaWartosc    = mojeWlasne.cosiek.1

        print("0: \(pierwszaWartosc) 1: \(drugaWartosc)") // ("private", "public")

        // Jak widać bez problemu możemy się odwołać do "prywatnej" wartości... parawie.
        // Tutaj w grę wchodzi sytuacja gdzie __cosiek__ został zainicjowany z wartością,
        // która była dostępna w pliku definiującym ale została __skopiowana__.

        // Gdybyśmy chcieli przekazać do __cośka__ coś co jest zadeklarowane jako private
        // to kompilator nam na to nie pozwoli.
        //
        // Plik WlasnyTyp.swift
        // let cosiek = (losowaLiczba, cytat, Pogodynka(imie: "Jadwiga"))
        //
        // Nie możemy tego zrobić ponieważ __Typ__ jest widoczny w tamtym pliku.



        // 💡: Zakomentuj definicje init() we WlasnyFramework
        let frameworkowaInstancja = FrameworkowaKlasa.init()

        // Ponieważ domyślnym modyfikatorem dostępu we Frameworku jest __internal__ to nie możemy
        // odwołać się do tej właściwości. Jest to swego rodzaju zabezpieczenie aby przez przpadek
        // nie "wyciekły" właściwości i metody. Aby móc skorzystać z jakiekolwiek metody i/lub
        // właściwości musi być ona oznaczona jako __public__.
//        frameworkowaInstancja.imie // 💥
        print(frameworkowaInstancja)




        // Taki "symbol" jest zdefiniowany w 2 miejscach z czego w obu jako __private__.
        // Aby ulżyć kompilatorowi w jego cierpieniach należy oznaczyć dowolny z nich
        // jako __public__ lub ten znajdujący się w targecie aplikacji jako __internal__ 
        // (lub skasowac modyfikator).
//        let losowa = losowaLiczba // ⚡️

        // Co w wypadku gdy oba symbole są zadeklarowane jako __public__ ?
        var slowaSlowaSlowa = cytat
        print(slowaSlowaSlowa)

        // Jak widzimy pierwszeństwo mają symbole zadeklarowane w tym samym module. Co ciekawe
        // jeżeli identyczny symobl jest zdefiniowany w zewnętrznych modułach to kod się nie
        // skompiluje.

        // Aby "wybrać" o którą wersję nam chodzi możemy użyć nazwy modułu, który tworzy
        // nam coś na wzór "przestrzenii nazw". Tylko na rozmowach o pracę proszę tak nie mówić ;)
        slowaSlowaSlowa = WlasnyFramework.cytat
        print(slowaSlowaSlowa)



        let frameworkowaStruktura = FrameworkowaStruktura()
//        print(frameworkowaStruktura.madroscNaDzien) // 💥
        print(frameworkowaStruktura.madroscNaJutro) // publiczne rozszerzenie
        print(frameworkowaStruktura.madroscNaWieki) // publiczna zmienna w wewnętrznym rozszerzeniu


    }
}

