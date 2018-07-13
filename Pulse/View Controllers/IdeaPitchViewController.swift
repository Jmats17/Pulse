//
//  IdeaPitchViewController.swift
//  Pulse
//
//  Created by Justin Matsnev on 7/12/18.
//  Copyright © 2018 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit
import DropDown

class IdeaPitchViewController : UIViewController {
    
    @IBOutlet weak var privateSwitch : AnimatedSwitch!
    @IBOutlet weak var titleField : UITextField!
    @IBOutlet weak var ideaField : UITextView!
    @IBOutlet weak var ideaPictureField : UIImageView!
    @IBOutlet weak var privateLabel : UILabel!
    @IBOutlet weak var categoryLabel : UILabel!
    @IBOutlet weak var dropDownView : UIView!
    @IBOutlet weak var submitButton : UIButton!

    let animatedSwitch = AnimatedSwitch()
    var isAnimated = true
    let dropDown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        ideaField.delegate = self
        
        submitButton.layer.cornerRadius = 5.0
        
        dropDownView.layer.cornerRadius = 5.0
        dropDownView.layer.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0).cgColor
        dropDown.anchorView = dropDownView
        dropDown.dataSource = ["Team Building", "Cost Cutting", "Product", "Onboarding", "Office", "Other"]
        
        styleTextFieldTextView()
        privateSwitch.animationDidStart = {
            if self.isAnimated {
                self.ideaPictureField.image = #imageLiteral(resourceName: "Lightbulbwhite")
                self.titleField.layer.backgroundColor = UIColor.white.cgColor
                self.privateLabel.textColor = UIColor.white
                self.submitButton.layer.backgroundColor = UIColor.white.cgColor
                self.submitButton.setTitleColor(UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0), for: .normal)
                self.isAnimated = false
            }
            else {
                self.ideaPictureField.image = #imageLiteral(resourceName: "Lightbulb")
                self.privateLabel.textColor = UIColor.lightGray
                self.ideaField.textColor = UIColor.black
                self.titleField.textColor = UIColor.black
                self.submitButton.layer.backgroundColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0).cgColor
                self.submitButton.setTitleColor(UIColor.white, for: .normal)
                self.isAnimated = true
            }
        }

        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let dropDownTapped = self.view.hitTest(firstTouch.location(in: self.view), with: event)
            
            if dropDownTapped === dropDownView {
                print("touch is inside")
                dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)

                self.dropDown.show()
                self.dropDown.direction = .bottom
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.categoryLabel.text = item
                    print("Selected item: \(item) at index: \(index)")
                }
                
            } else {
                print("touch is outside")
            }
        }
    }
    
    @IBAction func submit(sender : UIButton) {
        let alert = UIAlertController(title: "Idea Submitted!", message: "Thanks for sharing Justin. If we like it, maybe we'll take you out to coffee to learn more ;)", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Thanks!", style: .cancel) { (action) in
            self.titleField.text = ""
            self.ideaField.text = ""
            self.categoryLabel.text = "Select Category"
        }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func styleTextFieldTextView() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: titleField.frame.height))
        titleField.leftView = paddingView
        titleField.leftViewMode = UITextFieldViewMode.always
        titleField.layer.borderWidth = 1.0
        titleField.layer.borderColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0).cgColor
        titleField.layer.cornerRadius = 5.0
        
        ideaField.text = "Explain your idea here"
        ideaField.textColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 0.5)
        ideaField.layer.borderWidth = 1.0
        ideaField.layer.borderColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0).cgColor
        ideaField.layer.cornerRadius = 5.0
    }
    
    
}

extension IdeaPitchViewController : UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.titleField.resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        ideaField.text = ""
        ideaField.textColor = UIColor.black
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n")
        {
            view.endEditing(true)
            return false
        }
        else
        {
            return true
        }
    }
    
    
}








