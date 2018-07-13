//
//  PopupViewController.swift
//  Pulse
//
//  Created by Justin Matsnev on 7/13/18.
//  Copyright © 2018 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit

class PopupViewController : UIViewController {
    
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var dateAuthorLbl : UILabel!
    @IBOutlet weak var descriptionLbl : UITextView!

    var pulseTitle : String?
    var dateAuthor : String?
    var pulseDescription : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let title = pulseTitle {
            titleLbl.text = title
        }
        if let dateAuthor = dateAuthor {
            dateAuthorLbl.text = dateAuthor
        }
        if let description = pulseDescription {
            descriptionLbl.text = description
        }
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
    }
    

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
                dismiss(animated: true, completion: nil)
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
}
