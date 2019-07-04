//
//  Knight.swift
//  DungeonGame
//
//  Created by Aaron Michael Bisbal on 2019-06-25.
//  Copyright © 2019 Dylan Rampersad. All rights reserved.
//
import SpriteKit

enum knightSettings {
    static let knightDistance: CGFloat = 16
}

class Knight: SKSpriteNode {
    
    var animations: [SKAction] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        animations = aDecoder.decodeObject(forKey: "knight.animations")
            as! [SKAction]
    }
    
    init() {
        let texture = SKTexture(pixelImageNamed: "knight-1")
        super.init(texture: texture, color: .white,
                   size: texture.size())
        name = "knight"
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.restitution = 0.5
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = PhysicsCategory.Knight
        
        createAnimations(character: "knight")
    }
    
    @objc func moveknight() {

        let randomX = CGFloat(Int.random(in: -1...1))
        let randomY = CGFloat(Int.random(in: -1...1))
        
        let vector = CGVector(dx: randomX * knightSettings.knightDistance,
                              dy: randomY * knightSettings.knightDistance)

        let moveBy = SKAction.move(by: vector, duration: 1)
        let moveAgain = SKAction.perform(#selector(moveknight),
                                         onTarget: self)
        

        let direction = animationDirection(for: vector)
        // 2
        if direction == .left {
            xScale = abs(xScale)
        } else if direction == .right {
            xScale = -abs(xScale)
        }
        // 3
        run(animations[direction.rawValue], withKey: "animation")
        run(SKAction.sequence([moveBy, moveAgain]))
    }
    
    func die() {
   
        removeAllActions()
        yScale = -1
     
        physicsBody = nil
        run(SKAction.sequence([SKAction.fadeOut(withDuration: 3),
                               SKAction.removeFromParent()]))
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(animations, forKey: "knight.animations")
        super.encode(with: aCoder)
    }
}

extension Knight : Animatable {}
