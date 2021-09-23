//
//  TouchView.swift
//  WordGames
//
//  Created by Beth Silverstein using a lot of code from the lectures
//

import UIKit

class TouchView: UIImageView {
    
    
    var points : [CGPoint] = []
    var message : String = "Touch view"
    var tapMessage : String = ""
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
 */

    var timer: Timer?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches("touchBegan", touches: touches)
        tapMessage = ""
        if let touch = touches.first {
            if touch.tapCount >= 2 {
                timer?.invalidate()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches("touchMoved", touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches("touchEnded", touches: touches)
        if let touch = touches.first {
            if touch.tapCount == 2 {
                handleDoubleTap()
            } else {
                timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) {
                    _ in self.handleSingleTap()
                }
            }
        }
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {
            _ in self.clearTouches()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches("touchCancelled", touches: touches)
    }
    
    func handleTouches(_ method: String, touches: Set<UITouch>) {
        message = method + "[\(touches.count)]:"
        points.removeAll(keepingCapacity: true)
        for touch in touches {
            let p = touch.location(in: self)
            message += String(format: " (%.2f, %.2f)", p.x, p.y)
            points.append(p)
        }
        setNeedsDisplay()
    }
    
    func handleSingleTap() {
        tapMessage = "Single tap!"
        //print("Single tap!")
        startAnimation()
        setNeedsDisplay()
    }
    
    func handleDoubleTap() {
        tapMessage = "Double tap!!"
        //print("Double tap!!")
        self.transform = .identity
        setNeedsDisplay()
    }
    
    func clearTouches() {
        message = ""
        tapMessage = ""
        points.removeAll(keepingCapacity: true)
        setNeedsDisplay()
    }
    
    func startAnimation() {
        let duration = 2.0
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        })
        if lizardSpins == 0 {
            lizardSpinFound = true
        }
        lizardSpins += 1
    }
}
