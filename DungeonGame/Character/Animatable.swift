//
//  Animatable.swift
//  DungeonGame
//
//  Created by Aaron Michael Bisbal on 2019-06-28.
//  Copyright © 2019 Dylan Rampersad. All rights reserved.
//

import Foundation
import SpriteKit

protocol Animatable: class {
    var animations: [SKAction] { get set }
}

extension Animatable {
    func animationDirection(for directionVector: CGVector)
        -> Direction {
            let direction: Direction
            if abs(directionVector.dy) > abs(directionVector.dx) {
                direction = directionVector.dy < 0 ? .forward : .backward
            } else {
                direction = directionVector.dx < 0 ? .left : .right
            }
            return direction
    }
    func createAnimations(character: String) {
    let actionLeft: SKAction = SKAction.animate(with: [
            SKTexture(pixelImageNamed: "\(character)_l1"),
            SKTexture(pixelImageNamed: "\(character)_l3")
            ], timePerFrame: 0.2)
        animations.append(SKAction.repeatForever(actionLeft))
        
        animations.append(SKAction.repeatForever(actionLeft))
    }
}
