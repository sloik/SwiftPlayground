
import Cocoa
import CustomFramework

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ///******************///
        /// INTERNAL ACCESS *///
        ///******************///
        
        /// `ApplicationClass` is in the same target and default visibility
        /// is __internal__.
        let appClassInstance = ApplicationClass()
        
        let firstFromTuple = appClassInstance.tupleOfPrivatePublic.0
        print(#function, #line, firstFromTuple)
        
        let lastFromTuple = appClassInstance.tupleOfPrivatePublic.1
        print(#function, #line, lastFromTuple)
        
        
        let frameworkClassInstance = FrameworkClass()
        
        /// Accessing internal property of a framework class is
        /// impossible from project!
        /// 💥 'name' is inaccessible due to 'internal' protection level
//        frameworkClassInstance.name
        
        /// What about global symbols from application target?
        var wordsWordsWords = quote
        print(#function, #line, wordsWordsWords)
        
        /// It looks that compiler is trying to match symbol
        /// closest to the current/working target. That's why
        /// implementation from the app is used.
        
        wordsWordsWords = CustomFramework.quote
        print(#function, #line, wordsWordsWords)

        /// After telling the compiler which symbol to use
        /// we have access to the framework implementation.

        let frameworkStructureInstance = FrameworkStructure()
        
        /// Accessing public property of an internal extension.
        print(#function, #line, frameworkStructureInstance.quoteForLife)
        
        /// Accessing public property of a public extension.
        print(#function, #line, frameworkStructureInstance.quoteForTomorrow)

        
        ///*****************///
        /// PRIVATE ACCESS *///
        ///*****************///
        
        /// Accessing private property is disallowed:
        /// 💥 'password' is inaccessible due to 'private' protection level
//        appClassInstance.password
        
        /// There is no sense in checking framework symbols.
        /// They all will be inaccessible.        
        
        
        /// disable unused warnings ;)
        _ = type(of: frameworkClassInstance)

    }
}

