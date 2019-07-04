import SpriteKit
import CoreMotion
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    var player = Player()
    
    let joystickBase = SKSpriteNode(imageNamed: "joystickBase")
    let joystickBall = SKSpriteNode(imageNamed: "joystickBall")
    let radiansOf90Deg: CGFloat = 1.57
    let moveSpeed: CGFloat = 30
    var joystickNeeded: Bool = true
    var joystickActive: Bool = false
    var joystickAutoCenter: Bool = true
    var joystickSpeed: CGFloat = -0.002
    let motionManager = CMMotionManager()
    var xAcceleration = CGFloat(0)
    var yAcceleration = CGFloat(0)
    
    let buttonA = SKSpriteNode(imageNamed: "joystickBall")
    let buttonB = SKSpriteNode(imageNamed: "joystickBall")
    
    var bHit: Bool = false
    var aHit: Bool = false
    
    var jumpForce = CGVector(dx:0,dy:100)
    
    
    var gameState: GameState = .initial {
        didSet {
            hud.updateGameState(from: oldValue, to: gameState)
        }
    }
    
    var wizardNode = SKNode()
    
    var hud = HUD()
    var background: SKTileMapNode!
    var timeLimit: Int = 10
    var elapsedTime: Int = 0
    var startTime: Int?
    var currentLevel: Int = 1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let timeLimit = userData?.object(forKey: "timeLimit") as? Int{
            self.timeLimit = timeLimit
        }
        
        let savedGameState = aDecoder.decodeInteger(forKey: "Scene.gameState")
        if let gameState = GameState(rawValue: savedGameState),gameState == .pause{
            self.gameState = gameState
            elapsedTime = aDecoder.decodeInteger(forKey: "Scene.elapsedTime")
            currentLevel = aDecoder.decodeInteger(forKey: "Scene.currentLevel")
            
            player = childNode(withName: "Player")as! Player
            hud = camera!.childNode(withName: "HUD")as! HUD
            wizardNode = childNode(withName: "Wizard")!
   
        }
    
    }
    
    override func didMove(to view: SKView) {
        if gameState == .initial{
            addChild(player)
            spawnWizard()
            setupHUD()
            setupJoystick()
            setupButton()
            
            physicsWorld.contactDelegate = self
            scene?.physicsBody = SKPhysicsBody(edgeLoopFrom: scene!.frame)
            
            gameState = .start
        }
        setupCamera()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if player != nil{
            //print("\(player.position.x)")
            player.position = CGPoint(x: player.position.x + xAcceleration * moveSpeed, y: player.position.y)
            if(xAcceleration <= 0){
                player.xScale = 2
            } else {
                player.xScale = -2
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //if joystickNeeded == true {
        for touch in touches {
            let location = touch.location(in: self)
            
            if(buttonA.frame.contains(location)){
                aPressed()
                
            }
            if(buttonB.frame.contains(location)){
                bPressed()
            }
            if (joystickBall.frame.contains(location)) {
                joystickActive = true
            } else {
                joystickActive = false
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if joystickNeeded == true {
            for touch in touches {
                let location = touch.location(in: self)
                let v = CGVector(dx: location.x - joystickBase.position.x, dy: location.y - joystickBase.position.y)
                let angle = atan2(v.dy, v.dx)
                let length: CGFloat = joystickBase.frame.size.height / 2
                let xDist: CGFloat = sin(angle - radiansOf90Deg) * length
               // let yDist: CGFloat = cos(angle - radiansOf90Deg) * length
                
                if (joystickBase.frame.contains(location)) {
                    joystickBall.position = location
                }
                //                   else {
                //                    joystickBall.position = CGPointMake(joystickBase.position.x - xDist, joystickBase.position.y + yDist)
                //                }
                
                xAcceleration = xDist * joystickSpeed
               // yAcceleration = (yDist * joystickSpeed) * -1
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if joystickNeeded == true {
            if (joystickActive == true && joystickAutoCenter == true)  {
                let returnToCenter: SKAction = SKAction.move(to: joystickBase.position, duration: 0.2)
                returnToCenter.timingMode = .easeOut
                joystickBall.run(returnToCenter)
                xAcceleration = 0.0
                yAcceleration = 0.0
            }
        }
        aHit = false
        bHit = false
        joystickActive = false
    }
    
    func aPressed(){
        player.physicsBody?.applyImpulse(jumpForce)
    }
    
    func bPressed(){
        //        bHit = true
        //        if(!aHit){
        print("B hit")
        //       }
    }
    
    func setupButton() {
        
        
        buttonA.size = CGSize(width: 50, height: 50)
        buttonB.size = CGSize(width: 50, height: 50)
        buttonB.color = SKColor.blue
        buttonB.colorBlendFactor = 1
        buttonA.position = CGPoint(x: 150, y: -100)
        buttonB.position = CGPoint(x: 100, y: -100)
        
        
        addChild(buttonA)
        addChild(buttonB)
    }
    
    func setupJoystick() {
        joystickNeeded = true
        joystickBase.scale(to: CGSize(width: 100, height: 100))
        scene?.addChild(joystickBase)
        let joyPos = CGPoint(x: -size.width/2 + 200, y: -size.height/2 + 200)
        joystickBase.position = joyPos
        joystickBase.name = "JoystickBase"
        //
        joystickBase.zPosition = 1
        print("Joystick Added")
        joystickBall.scale(to: CGSize(width: 100, height: 100))
        scene?.addChild(joystickBall)
        joystickBall.position = joystickBase.position
        joystickBall.name = "JoystickBall"
        //
        joystickBall.zPosition = 2
    }
    
    func setupHUD() {
        camera?.addChild(hud)
        hud.addTimer(time: timeLimit)
    }
    
    func setupCamera() {
        guard let camera = camera, let view = view else { return }
        
        let zeroDistance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(zeroDistance,
                                                     to: player)
        // 1
        let xInset = min(view.bounds.width/2 * camera.xScale,
                         background.frame.width/2)
        let yInset = min(view.bounds.height/2 * camera.yScale,
                         background.frame.height/2)
        
        // 2
        let constraintRect = background.frame.insetBy(dx: xInset,
                                                      dy: yInset)
        // 3
        let xRange = SKRange(lowerLimit: constraintRect.minX,
                             upperLimit: constraintRect.maxX)
        let yRange = SKRange(lowerLimit: constraintRect.minY,
                             upperLimit: constraintRect.maxY)
        
        let edgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        edgeConstraint.referenceNode = background
        // 4
        camera.constraints = [playerConstraint, edgeConstraint]
    }
    
    func spawnWizard(){
        guard let wizardMap = childNode(withName: "wizard")
            as? SKTileMapNode else {return}
        for row in 0..<wizardMap.numberOfRows{
            for column in 0..<wizardMap.numberOfColumns{
                guard let tile = tile(in: wizardMap, at: (column,row))
                    else{continue}
                let wizard: Wizard
                wizard = Wizard()
                wizard.position = wizardMap.centerOfTile(atColumn: column, row: row)
                wizardNode.addChild(wizard)
                wizard.moveWizard()
            }
        }
        wizardNode.name = "Wizard"
        addChild(wizardNode)
        wizardMap.removeFromParent()
    }
    func tile(in tileMap: SKTileMapNode,
              at coordinates: TileCoordinates)
        -> SKTileDefinition? {
            return tileMap.tileDefinition(atColumn: coordinates.column,
                                          row: coordinates.row)
    }
    
    
    
    
    class func loadGame() -> SKScene? {
        print("* loading game")
        var scene: SKScene?
        // 1
        let fileManager = FileManager.default
        guard let directory =
            fileManager.urls(for: .libraryDirectory,
                             in: .userDomainMask).first
            else { return nil }
        // 2
        let url = directory.appendingPathComponent(
            "SavedGames/saved-game")
        // 3
        if FileManager.default.fileExists(atPath: url.path) {
            scene = NSKeyedUnarchiver.unarchiveObject(
                withFile: url.path) as? GameScene
            _ = try? fileManager.removeItem(at: url)
        }
        return scene
    }}

