//
//  HangmanView.swift
//  WordGames
//
//  Created by Beth Silverstein
//

import UIKit

class HangmanView: UIView {
    
    var hangmanStage = 0
    
    func drawGallows(context: CGContext) {
        //create the gallows
        //side
        context.move(to: CGPoint(x: 200, y: 30))
        context.addLine(to: CGPoint(x: 200, y: 280))
        //bottom
        context.move(to: CGPoint(x: 50, y: 280))
        context.addLine(to: CGPoint(x: 250, y: 280))
        //top
        context.move(to: CGPoint(x: 100, y: 30))
        context.addLine(to: CGPoint(x: 200, y: 30))
        context.setLineWidth(3)
        //that little bit that sticks down from the top, idk what to call it... the noose I guess? This game is hella dark
        context.move(to: CGPoint(x: 100, y: 30))
        context.addLine(to: CGPoint(x: 100, y: 50))
        context.strokePath()
    }
    
    func drawHead(context: CGContext) {
        //create the guy's head
        context.setLineWidth(2)
        let head = CGRect(x: 75, y: 50, width: 50, height: 50)
        context.strokeEllipse(in: head)
    }
    
    func drawBody(context: CGContext) {
        //create the guy's body
        context.move(to: CGPoint(x: 100, y: 100))
        context.addLine(to: CGPoint(x: 100, y: 200))
        context.strokePath()
    }
    
    func drawRightLeg(context: CGContext) {
        //create the guy's right leg (my right)
        context.move(to: CGPoint(x: 100, y: 200))
        context.addLine(to: CGPoint(x: 130, y: 230))
        context.strokePath()
    }
    
    func drawLeftLeg(context: CGContext) {
        //create the guy's left leg
        context.move(to: CGPoint(x: 100, y: 200))
        context.addLine(to: CGPoint(x: 70, y: 230))
        context.strokePath()
    }
    
    func drawRightArm(context: CGContext) {
        //create the guy's right arm (again, my right)
        context.move(to: CGPoint(x: 100, y: 130))
        context.addLine(to: CGPoint(x: 130, y: 140))
        context.strokePath()
    }
    
    func drawLeftArm(context: CGContext) {
        //create the guy's left arm
        context.move(to: CGPoint(x: 100, y: 130))
        context.addLine(to: CGPoint(x: 70, y: 140))
        context.strokePath()
    }
    
    func drawSadFace(context: CGContext) {
        context.setLineWidth(1)
        let eye1 = CGRect(x: 85, y: 70, width: 5, height: 5)
        context.fillEllipse(in: eye1)
        let eye2 = CGRect(x: 110, y: 70, width: 5, height: 5)
        context.fillEllipse(in: eye2)
        
        context.addArc(
            center: CGPoint(x: 100, y: 90),
            radius: 10,
            startAngle: 0,
            endAngle: .pi,
            clockwise: true)
        context.strokePath()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        if let context = UIGraphicsGetCurrentContext() {
            
            //this is FOR SURE not the best way to do this but I'm not sure how to do it otherwise :(
            switch hangmanStage {
            
            case 0:
                drawGallows(context: context)
            case 1:
                drawGallows(context: context)
                drawHead(context: context)
            case 2:
                drawGallows(context: context)
                drawHead(context: context)
                drawBody(context: context)
            case 3:
                drawGallows(context: context)
                drawHead(context: context)
                drawBody(context: context)
                drawRightLeg(context: context)
            case 4:
                drawGallows(context: context)
                drawHead(context: context)
                drawBody(context: context)
                drawRightLeg(context: context)
                drawLeftLeg(context: context)
            case 5:
                drawGallows(context: context)
                drawHead(context: context)
                drawBody(context: context)
                drawRightLeg(context: context)
                drawLeftLeg(context: context)
                drawRightArm(context: context)
            case 6:
                drawGallows(context: context)
                drawHead(context: context)
                drawBody(context: context)
                drawRightLeg(context: context)
                drawLeftLeg(context: context)
                drawRightArm(context: context)
                drawLeftArm(context: context)
            default:
                drawGallows(context: context)
                drawHead(context: context)
                drawBody(context: context)
                drawRightLeg(context: context)
                drawLeftLeg(context: context)
                drawRightArm(context: context)
                drawLeftArm(context: context)
                drawSadFace(context: context)
            }
        }
    }
    

}
