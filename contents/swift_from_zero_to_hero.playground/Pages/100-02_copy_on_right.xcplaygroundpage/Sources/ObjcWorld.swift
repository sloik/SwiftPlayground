import Foundation

@objc public class ObjcWorld: NSObject, NSCopying {
    
    public var wiek: Int
    public var rasa: String
    
    public init(rasa: String, wiek: Int) {
        self.rasa = rasa
        self.wiek = wiek
    }
    
    override public var description: String {
        return "\(rasa): \(wiek)"
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return ObjcWorld(rasa: rasa, wiek: wiek)
    }
}

