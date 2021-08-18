
import Foundation

fileprivate class FrameworkFilePrivateClass {
    fileprivate var fileprivateName: String { "FrameworkFilePrivateClass" }
    
    func performActionWithPrivateClassInTheSameFile() {
        /// 🤔 why you do this Swift... you allow me
        /// to create an instance of a private class...
        /// (init has internal default access but the type itself is private...)
        let instance = InFilePrivateButPrivateClass()
        
        /// but disallow me to use this private property...
        /// 💥 'fileprivateName' is inaccessible due to 'private' protection level
//        instance.fileprivateName
    }
}

func demoForFileprivateAccess() {
    let instance = FrameworkFilePrivateClass()
    _ = instance.fileprivateName
}


private class InFilePrivateButPrivateClass {
    private var fileprivateName: String { "InFilePrivateButPrivateClass" }
}
