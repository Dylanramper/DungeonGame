import SpriteKit

enum WizardSettings {
    static let WizardDistance: CGFloat = 16
}

class Wizard: SKSpriteNode {
    
    var animations: [SKAction] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        animations = aDecoder.decodeObject(forKey: "Wizard.animations")
            as! [SKAction]
    }
    
    init() {
        let texture = SKTexture(pixelImageNamed: "wizard_1")
        super.init(texture: texture, color: .white,
                   size: texture.size())
        name = "Wizard"
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.restitution = 0.5
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = PhysicsCategory.Wizard
        
        createAnimations(character: "wizard")
    }
    
    @objc func moveWizard() {
        // 1
        let randomX = CGFloat(Int.random(in: -1...1))
        let randomY = CGFloat(Int.random(in: -1...1))
        
        let vector = CGVector(dx: randomX * WizardSettings.WizardDistance,
                              dy: randomY * WizardSettings.WizardDistance)
        // 2
        let moveBy = SKAction.move(by: vector, duration: 1)
        let moveAgain = SKAction.perform(#selector(moveWizard),
                                         onTarget: self)
        
        // 1
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
        // 1
        removeAllActions()
        texture = SKTexture(pixelImageNamed: "bug_lt1")
        yScale = -1
        // 2
        physicsBody = nil
        // 3
        run(SKAction.sequence([SKAction.fadeOut(withDuration: 3),
                               SKAction.removeFromParent()]))
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(animations, forKey: "Bug.animations")
        super.encode(with: aCoder)
    }
}

extension Wizard : Animatable {}

