//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Live Preview
/*:
Czasami chcemy wyświetlić jakiś widok, który będzie pełnił role _sceny_. Ten eksta widok będzie widoczny po włączeniu _assistent editora_.
*/

import UIKit
import PlaygroundSupport

// widok, który posłuży nam za scenę
let scena = UIView(frame: CGRect(x: 0,y: 0,width: 300,height: 300))
scena.backgroundColor = UIColor.red.withAlphaComponent(0.25)

// magia 💎
PlaygroundPage.current.liveView = scena

// kod dodajacy animacje i inne bajery
let viewToAnimate = UIView(frame: CGRect(x: 0,y: 0,width: 20,height: 20))
viewToAnimate.backgroundColor = .green

scena.addSubview(viewToAnimate)

let oval = UIBezierPath(ovalIn: scena.bounds.insetBy(dx: 40, dy: 40))

let moveAnimation = CAKeyframeAnimation(keyPath: "position")
moveAnimation.path = oval.cgPath
moveAnimation.calculationMode = .paced

let animGroup = CAAnimationGroup()
animGroup.duration = 5
animGroup.repeatCount = HUGE
animGroup.animations = [moveAnimation]

viewToAnimate.layer.add(animGroup, forKey: nil)

//: Interakcja
class ButtonHandler: NSObject {
    @objc func buttonTapniety() {
        print("ale było")
    }
}
let handler = ButtonHandler()

let button = UIButton.init(type: .system)
button.addTarget(handler, action: #selector(ButtonHandler.buttonTapniety), for: .touchUpInside)

button.setTitle("Tapnij Mnie", for: UIControl.State())
button.frame = CGRect(x: 100, y: 150, width: 100, height: 20)


scena.addSubview(button)

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
