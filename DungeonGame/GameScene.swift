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
    var background: SKTileMapNode!
    
    override func didMove(to view: SKView) {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: -432.0, y: -80.0)
        player.name = "player"
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        
        platforms = childNode(withName: "platforms") as? SKTileMapNode
        
        setupPlatforms()
    }
    
    typealias TileCoordinates = (column: Int, row: Int)
    
    func tile(in tileMap: SKTileMapNode, at coordinates: TileCoordinates) -> SKTileDefinition?{
        return tileMap.tileDefinition(atColumn: coordinates.column, row: coordinates.row)
    }
    
    func setupPlatforms(){
        guard let platforms = platforms else {return}
        //1
        var physicsbody = [SKPhysicsBody]()
        //2
        for row in 0..<platforms.numberOfRows{
            for column in 0..<platforms.numberOfColumns{
                guard let tile = tile(in: platforms, at: (column, row))
                    else{continue}
                //3
                let center = platforms.centerOfTile(atColumn: column, row: row)
                let body = SKPhysicsBody(rectangleOf: tile.size, center: center)
                physicsbody.append(body)
            }
        }
        //4
        platforms.physicsBody = SKPhysicsBody(bodies: physicsbody)
        platforms.physicsBody?.isDynamic = false
        platforms.physicsBody?.friction = 0
    }
}
