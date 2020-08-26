//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
//:> ## Asynchroniczny Plac Zabaw

import Foundation

//: Przy bawieniu się kodem asynchronicznym potrzebujemy __wymusić__ dłuższe wykonywanie placu zabaw. Poniżej przepis na to ;)

import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution = true

//: Przyklad kodu asynchronicznego

let queue = DispatchQueue.global(qos: .background)

queue.async() { sleep(1) ; print("Task 1") }
print("1 Done")

queue.async() { print("Task 2") }
print("2 Done")


//: Jeżeli chcemy aby po pewnym czasie wykonywanie placu zabaw się zakończyło to możemy to zrobić w ten sposób

sleep(3) // dodane tylko po to aby kod asynchroniczny mial odrobine czasu na wykonanie się.
PlaygroundPage.current.finishExecution()

//:[ToC](00-00_toc) | [Tips and Tricks](900-00-tips_and_tricks) | [Previous](@previous) | [Next](@next)
