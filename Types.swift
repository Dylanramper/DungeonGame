import Foundation

enum Direction: Int {
    case forward = 0, backward, left, right
}

typealias TileCoordinates = (column: Int, row: Int)

struct PhysicsCategory {
    static let None:         UInt32 = 0
    static let All:          UInt32 = 0xFFFFFFFF
    static let Wizard:       UInt32 = 0b100
    static let Knight:       UInt32 = 0b1000
    static let FlameDemon:   UInt32 = 0b10000
    static let Player:       UInt32 = 0b100000
    static let Platform:     UInt32 = 0b1000000
}

enum GameState: Int {
    case initial=0, start, play, win, lose, reload, pause
}

