//
//  Pulse.swift
//  Pulse
//
//  Created by Justin Matsnev on 7/13/18.
//  Copyright © 2018 Justin Matsnev. All rights reserved.
//

import Foundation

class Pulse  {
    
    var title : String
    var date = Date()
    var author : String
    var description : String
    var isPinned : Bool
    
    init(title : String, author : String, description : String, isPinned : Bool = false) {
        self.title = title
        self.author = author
        self.description = description
        self.isPinned = isPinned
    }
}
