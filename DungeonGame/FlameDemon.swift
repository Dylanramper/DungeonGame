//
//  FlameDemon.swift
//  DungeonGame
//
//  Created by Aaron Michael Bisbal on 2019-06-25.
//  Copyright © 2019 Dylan Rampersad. All rights reserved.
//

import Foundation
import SpriteKit

class FlameDemon: SKSpriteNode{
    var animations:[SKAction] = []
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        animations = aDecoder.decodeObject(forKey: "<#T##String#>")
            as! [SKAction]
        
    }
    
    /*init(){
        let texture = SKTexture(pixelImageNamed: "FlameDemon Evolved")
        super.init(texture: texture, color: .white, size: texture.size())
        name = "FlameDemon"
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.restitution = 0.5
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = PhysicsCategory.FlameDemon
        
        createAnimations(character: "FlameDemon")
    }*/
    
    /*func die(){
        removeAllActions()
        texture = SKTexture(pixelImageNamed: "insert explosion image here")
        yScale = -1
        physicsBody = nil
        run(SKAction.sequence([SKAction.fadeOut(withDuration: 3), SKAction.removeFromParent()]))
    }*/
    
    /*override func encode(with aCoder: NSCoder){
        aCoder.encode(animations, forKey: "FlameDemon.animation")
        super.encode(with: aCoder)
    }*/
    
}

//extension FlameDemon : Animatable{}
