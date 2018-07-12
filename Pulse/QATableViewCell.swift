//
//  QATableViewCell.swift
//  Pulse
//
//  Created by Justin Matsnev on 7/12/18.
//  Copyright © 2018 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit

class QATableViewCell : UITableViewCell {
    
    @IBOutlet weak var questionLabel : UILabel!
    @IBOutlet weak var votesLabel : UILabel!
    @IBOutlet weak var upButton : UIButton!
    @IBOutlet weak var downButton : UIButton!
    
    weak var qaCellDelegate : QATableViewCellDelegate?
    
    @IBAction func upVoteTapped(_ sender : UIButton) {
        qaCellDelegate?.upVoteTapped(sender: self)
    }
    
    @IBAction func downVoteTapped(_ sender : UIButton) {
        qaCellDelegate?.downVoteTapped(sender: self)
    }
    

}
