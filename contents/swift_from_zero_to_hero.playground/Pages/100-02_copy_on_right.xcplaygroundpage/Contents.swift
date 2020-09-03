//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
import Foundation

//: # Copy on Write

//: Wiemy, że kolekcje/tablice w swifcie są kopiowane w momencie modyfikacji dowolnej referencji. Dzięki temu możemy mieć wiele nie mutujących referencji które odwołują się do tego samego miejsca w pamięci.

xtb("value semantics on arrays") { // to execute change `xtb` to `tb`
    let startowa = ["a", "b"]
    getBufferAddress(startowa)

    var druga = startowa
    getBufferAddress(druga)

    druga.append("c")
    
    getBufferAddress(startowa)
    getBufferAddress(druga)
}

xtb("reference semantics") {
    let cori = ObjcWorld(rasa: "Boston Terier", wiek: 8)
    String(unsafeBitCast(cori, to: Int.self), radix: 16)
    cori.wiek
    
    let refCori = cori
    String(unsafeBitCast(refCori, to: Int.self), radix: 16)

    refCori.wiek = 9
    cori.wiek
}

//: Zobaczmy co możemy zrobić aby nasze typy referencyjne zachowywały się bardziej jak typy wartościowe przy modyfikacji.

xtb("reference but value") {
    struct World: CustomStringConvertible {
        private var _objcWorl: ObjcWorld
        private var _mutatingObjcWorld: ObjcWorld {
            mutating get {
                print(".", terminator: " ")
                _objcWorl = _objcWorl.copy() as! ObjcWorld // 1408!
                return _objcWorl
            }
        }
        
        init(rasa: String, wiek: Int) {
            _objcWorl = ObjcWorld(rasa: rasa, wiek: wiek)
        }
        
        var rasa: String {
            get { return _objcWorl.rasa }
            set { _mutatingObjcWorld.rasa = newValue }
        }
        
        var wiek: Int {
            get { return _objcWorl.wiek }
            set { _mutatingObjcWorld.wiek = newValue }
        }
        
        var description: String { return _objcWorl.description }
    }
    
    var cori = World(rasa: "Boston Terier", wiek: 1)
    let psy: [World] = [cori]
    
    cori.wiek += 8
    cori.wiek += 5
    cori.wiek += 7

    print()
    print(psy)
    print(cori)
    
    //: Jak widać udało nam się osiągnąc taki efekt, że obie instancje żyją sobie osobno. Gdyby tylko nie to ciągłe kopiowanie...
    
    xtb("\t Mały problem z kopiowaniem") { // t: 1.1, 1.21, 1.00, 1.12, 1.16 ~1.118
        for _ in 0...700 {
            cori.wiek += 1
        }
    }
}

xtb("smarter reference but value") {
    final class SwiftRef<T> {
        var object: T
        init(_ o: T) {
            object = o
        }
    }
    
    struct World: CustomStringConvertible {
        private var _objcWorl         : SwiftRef<ObjcWorld>
        private var _mutatingObjcWorld: ObjcWorld {
            mutating get {
                if isKnownUniquelyReferenced(&_objcWorl) == false {
                    print(".", terminator: " ")
                    _objcWorl = SwiftRef( _objcWorl.object.copy() as! ObjcWorld ) // 705
                }
                
                return _objcWorl.object
            }
        }
        
        init(rasa: String, wiek: Int) {
            _objcWorl = SwiftRef( ObjcWorld(rasa: rasa, wiek: wiek) )
        }
        
        var rasa: String {
            get { return _objcWorl.object.rasa }
            set { _mutatingObjcWorld.rasa = newValue }
        }
        
        var wiek: Int {
            get { return _objcWorl.object.wiek }
            set { _mutatingObjcWorld.wiek = newValue }
        }
        
        var description: String { return _objcWorl.object.description }
    }
    
    var cori = World(rasa: "Boston Terier", wiek: 1)
    let psy: [World] = [cori]
    
    cori.wiek += 8
    cori.wiek += 5
    cori.wiek += 7
    
    print()
    print(psy)
    print(cori)
    
    xtb("\t Test Mutowania") { // t: .69, .90, .71, .65, .67 ~0.724 ~36% szybciej
        for _ in 0...700 {
            cori.wiek += 1
        }
    }
}

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)

