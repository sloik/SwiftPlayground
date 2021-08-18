
import Foundation

private class FrameworkFilePrivateClass {
    private var privateName: String { "FrameworkFilePrivateClass" }
    
    func performActionWithPrivateClassInTheSameFile() {
        /// Type has access to it's own private properties...
        _ = self.privateName
    }
}

func demoForPrivateAccess() {
    let instance = FrameworkFilePrivateClass()
    
    /// 💥 'privateName' is inaccessible due to 'private' protection level
//    _ = instance.privateName
}
