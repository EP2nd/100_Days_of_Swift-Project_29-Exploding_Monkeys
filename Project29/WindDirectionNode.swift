//
//  WindDirectionNode.swift
//  Project29
//
//  Created by Edwin Przeźwiecki Jr. on 06/11/2022.
//

/// Challenge 3:

import SpriteKit
import UIKit

class WindDirectionNode: SKSpriteNode {
    var currentWindDirection: UIImage!
    
    var currentGame: GameScene!
    var viewController: GameViewController!

    func setup() {
        currentWindDirection = drawWindDirectionPointer(size: size)
        texture = SKTexture(image: currentWindDirection)
    }
    
    func configurePhysics() {
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = CollisionTypes.pointer.rawValue
        
        var horizontalGravity = Double(Double.random(in: -10...10))
        currentGame.physicsWorld.gravity = CGVector(dx: horizontalGravity, dy: -9.8)
        viewController.windStrength = horizontalGravity
    }
    
    func setRandomWind() {
        
    }
    
    func drawWindDirectionPointer(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let img = renderer.image { ctx in
            switch viewController.windStrength {
            case -10 ... 0:
                ctx.cgContext.move(to: CGPoint(x: 30, y: 15))
                ctx.cgContext.addLine(to: CGPoint(x: 0, y: 15))
                ctx.cgContext.addLine(to: CGPoint(x: 5, y: 20))
                ctx.cgContext.move(to: CGPoint(x: 0, y: 15))
                ctx.cgContext.addLine(to: CGPoint(x: 5, y: 10))
            case 10 ... 0:
                ctx.cgContext.move(to: CGPoint(x: 0, y: 15))
                ctx.cgContext.addLine(to: CGPoint(x: 30, y: 15))
                ctx.cgContext.addLine(to: CGPoint(x: 25, y: 20))
                ctx.cgContext.move(to: CGPoint(x: 30, y: 15))
                ctx.cgContext.addLine(to: CGPoint(x: 25, y: 10))
            default:
                return
            }
        }
        return img
    }
}
