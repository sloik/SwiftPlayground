import Foundation

open class Person {
    
    public init() {}
    
    open func introduce() {
        print("calling method")
    }
    
    open func age() -> Int {
        return 42;
    }
}
