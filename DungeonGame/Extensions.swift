//
//  Extensions.swift
//  DungeonGame
//
//  Created by Aaron Michael Bisbal on 2019-06-28.
//  Copyright © 2019 Dylan Rampersad. All rights reserved.
//

import Foundation
import SpriteKit

extension SKTexture {
    convenience init(pixelImageNamed: String) {
        self.init(imageNamed: pixelImageNamed)
        self.filteringMode = .nearest
    }
}
