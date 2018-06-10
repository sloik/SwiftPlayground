import UIKit

extension UITraitCollection {
    override open var description: String {
        var result = ""

        let device = "Device: \(self.stringForUserInterfaceIdiom(idiom: self.userInterfaceIdiom))\n"
        result.append(device)

        let horizontal = "Horizontal: \(self.stringForSizeClass(size: self.horizontalSizeClass))\n"
        result.append(horizontal)

        let vertical = "Vertical: \(self.stringForSizeClass(size: self.verticalSizeClass))\n"
        result.append(vertical)

        let displayScale = "Display Scale: \(self.displayScale)\n"
        result.append(displayScale)

        let forceTouch = "Force Touch: \(self.stringForForceTouch(forceTouch: self.forceTouchCapability))\n"
        result.append(forceTouch)

        result.append("Display Gamut: \(self.gamutString)")

        return result
    }

    func stringForUserInterfaceIdiom(idiom: UIUserInterfaceIdiom) -> String {
        switch idiom {
        case .pad: return "iPad"
        case .phone: return "iPhone"
        case .tv: return "TV"
        case .unspecified: return "Unspecified"
        case .carPlay: return "CarPlay"
        }
    }

    func stringForSizeClass(size: UIUserInterfaceSizeClass) -> String {
        switch size {
        case .unspecified: return "Unspecified"
        case .compact: return "Compact"
        case .regular: return "Regular"
        }
    }

    func stringForForceTouch(forceTouch: UIForceTouchCapability) -> String {
        switch forceTouch {
        case .unknown: return "Unknown"
        case .unavailable: return "Unavailable"
        case .available: return "Available"
        }
    }

    var gamutString: String {
        switch self.displayGamut {
        case .P3: return "P3"
        case .SRGB: return "RGB"
        case .unspecified: return "Unspecified"
        }
    }

    func debugQuickLookObject() -> AnyObject {
        return self.description as AnyObject
    }
}
