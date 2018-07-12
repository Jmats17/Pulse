//
//  QATableViewCellDelegate.swift
//  Pulse
//
//  Created by Justin Matsnev on 7/12/18.
//  Copyright © 2018 Justin Matsnev. All rights reserved.
//

import Foundation

protocol QATableViewCellDelegate : class {
    
    func upVoteTapped(sender : QATableViewCell)
    func downVoteTapped(sender : QATableViewCell)
    
    
}
