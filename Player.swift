//
//  Player.swift
//  DungeonGame
//
//  Created by Dylan Rampersad on 2019-06-27.
//  Copyright © 2019 Dylan Rampersad. All rights reserved.
//

import Foundation
import SpriteKit

enum PlayerSettings{
    static let playerSpeed: CGFloat = 200.0
    
}

class Player: SKSpriteNode {
    
    func move(target: CGPoint){
        guard let physicsBody = physicsBody else{return}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use Init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "player")
        super.init(texture: texture, color: .white, size: texture.size())
        name = "Player"
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.restitution = 1.0
        physicsBody?.linearDamping = 1.0
        physicsBody?.friction = 1.3
        physicsBody?.allowsRotation = false
        
    }
}
