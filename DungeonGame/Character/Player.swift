import Foundation
import SpriteKit

enum PlayerSettings {
    static let playerSpeed: CGFloat = 280.0
}

class Player: SKSpriteNode {
    
    var animations: [SKAction] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        animations = aDecoder.decodeObject(
            forKey: "Player.animations") as! [SKAction]
    }
    
    init() {
        let texture = SKTexture(pixelImageNamed: "player_f1")
        super.init(texture: texture, color: .white,
                   size: texture.size())
        name = "Player"
        zPosition = 50
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.restitution = 0.1
        physicsBody?.linearDamping = 0.5
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
        
        physicsBody?.categoryBitMask = PhysicsCategory.Player
        physicsBody?.contactTestBitMask = PhysicsCategory.All
        
        createAnimations(character: "player")
    }
    
    /*func move(target: CGPoint) {
        guard let physicsBody = physicsBody else { return }
        
        let newVelocity = (target - position).normalized()
            * PlayerSettings.playerSpeed
        physicsBody.velocity = CGVector(point: newVelocity)
        
        checkDirection()
    }
    
    func checkDirection() {
        guard let physicsBody = physicsBody else { return }

        let direction =
            animationDirection(for: physicsBody.velocity)

        if direction == .left {
            xScale = abs(xScale)
        }
        if direction == .right {
            xScale = -abs(xScale)
        }
        // 3
        run(animations[direction.rawValue], withKey: "animation")
    }

    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(animations, forKey: "Player.animations")
        super.encode(with: aCoder)
    }*/
}

extension Player : Animatable {}
