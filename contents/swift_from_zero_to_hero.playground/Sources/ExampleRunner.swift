import Foundation

public var counter = 1

public func xrun(_ name: String? = nil, code: ()->()) {}
public func run(_ name: String? = nil, code: ()->()) {

    if let name = name {
        print("<- - - - - \(name) \(counter) - - - - ->\n\n")
    }

    code()

    if let name = name {
        print("\n\n<- - - - - \(name) \(counter) - - - - ->\n\n")
    }

    counter += 1
}

public func xtimed(_ label: String, block: ()->()) {}
public func timed(_ label: String, block: ()->()) {
    let start = Date()
    
    print("Starting: " + label + "\n")
    
    block()
    
    let elapsedTime = Date().timeIntervalSince(start)
    print("\n" + label + " \(elapsedTime)\n\n")
}

