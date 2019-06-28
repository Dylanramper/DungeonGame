//
//  Player.swift
//  DungeonGame
//
//  Created by Dylan Rampersad on 2019-06-27.
//  Copyright © 2019 Dylan Rampersad. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use Init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "player")
        super.init(texture: texture, color: .white, size: texture.size())
        name = "Player"
        
    }
}
