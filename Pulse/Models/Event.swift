//
//  Event.swift
//  Pulse
//
//  Created by Justin Matsnev on 7/13/18.
//  Copyright © 2018 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit

class Event  {
    
    var name : String
    var date = Date()
    var location : String
    var image : UIImage
    
    init(name : String, location : String, image : UIImage) {
        self.name = name
        self.location = location
        self.image = image
    }
}
