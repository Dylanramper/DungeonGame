//
//  GameScene.swift
//  DungeonGame
//
//  Created by Dylan Rampersad on 2019-06-19.
//  Copyright © 2019 Dylan Rampersad. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var player = SKSpriteNode()
    var platforms: SKTileMapNode?
    
    override func didMove(to view: SKView) {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: -432.0, y: -80.0)
        player.name = "player"
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        
        platforms = childNode(withName: "platforms") as? SKTileMapNode
    }
    
    func setupPlatforms(){
    
    }
}
