import Foundation
import SpriteKit

enum HUDSettings {
    static let font = "Noteworthy-Bold"
    static let fontSize: CGFloat = 50
}

enum HUDMessages{
    static let tapToStart = "Tap to Start"
    static let win = "Congratulations!"
    static let lose = "YOU LOSER!"
    static let nextLevel = "Next Level"
    static let levelComplete = "Level Complete"
    static let playAgain = "Tap to Play Again"
    static let reload = "Reload"
    static let yes = "YES"
    static let no = "HELL NO"
    
}
class HUD: SKNode{
    var timerLabel: SKLabelNode?
    override init() {
        super.init()
        name = "HUD"
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        timerLabel = childNode(withName: "Timer")as? SKLabelNode
    }
    
    //this is setting up the message setting up the fauntion to call
    func add(message: String, position: CGPoint,fontSize: CGFloat = HUDSettings.fontSize){
        let label: SKLabelNode
        label = SKLabelNode(fontNamed: HUDSettings.font)
        label.text = message
        label.name = message
        label.zPosition = 50
        addChild(label)
        label.fontSize = fontSize
        label.position = position
    }
    
    //this is just setting up the time
    func updateTimer(time: Int){
        let minutes = (time/60)%60
        let seconds = time % 60
        let timeText = String(format: "%020d:%02d", minutes,seconds)
        timerLabel?.text = timeText
    }
    
    //this is setting up the timer
    func addTimer(time: Int){
        guard let scene = scene else {return}
        let position = CGPoint(x:0, y:scene.frame.height/2 - 10)
        add(message: "Timer", position: position, fontSize: 20)
        timerLabel = childNode(withName: "Timer") as? SKLabelNode
        timerLabel?.verticalAlignmentMode = .top
        timerLabel?.fontName = "Menlo"
        updateTimer(time: time)
    }
    
    //this is going to update the state from state to state
    func updateGameState(from: GameState, to: GameState){
        clearUI(gameState: from)
        updateUI(gameState: to)
    }
    
    //this function updates the game state of the messages
    private func updateUI(gameState : GameState){
        switch gameState{
        case .win:
            add(message:HUDMessages.win,position: .zero)
            add(message: HUDMessages.nextLevel, position: CGPoint(x:0, y: -100))
        case .lose:
            add(message: HUDMessages.lose, position: .zero)
            add(message: HUDMessages.playAgain, position: CGPoint(x:0, y: -100))
        case . start:
            add(message: HUDMessages.tapToStart, position: .zero)
        case .reload:
            add(message: HUDMessages.reload, position: .zero, fontSize: 40)
            add(message: HUDMessages.yes, position: CGPoint(x:-140, y:-100))
            add(message: HUDMessages.no, position: CGPoint(x:130,y: -100))
        default:
            break
        }
    }
    
    private func clearUI(gameState: GameState){
        switch gameState {
        case .win:
            remove(message:HUDMessages.win)
            remove(message:HUDMessages.nextLevel)
        case .lose:
            remove(message:HUDMessages.lose)
            remove(message:HUDMessages.playAgain)
        case .start:
            remove(message:HUDMessages.tapToStart)
        case .reload:
            remove(message:HUDMessages.reload)
            remove(message:HUDMessages.yes)
            remove(message:HUDMessages.no)
        default:
            break
        }
    }
    private func remove(message:String){
        childNode(withName: message)?.removeFromParent()
    }
    
}
