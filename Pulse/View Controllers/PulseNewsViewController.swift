//
//  PulseNewsViewController.swift
//  Pulse
//
//  Created by Justin Matsnev on 7/13/18.
//  Copyright © 2018 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit


class PulseNewsViewController : UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var profImageView : UIImageView!
    var pulses = [Pulse]()
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        tableView.delegate = self
        generateEventData()
        generatePulseData()
        profImageView.image = UIImage(named: "elon.jpg")
        profImageView.layer.cornerRadius = profImageView.frame.size.height / 2

    }
  
    override func viewWillLayoutSubviews() {

       profImageView.layer.cornerRadius = profImageView.frame.size.height / 2
        profImageView.clipsToBounds = true

    }
    
    func generatePulseData() {
        let pulseOne = Pulse(title: "GE to the 3rd floor", author: "Elon Musk", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin iaculis nisl sagittis augue viverra facilisis. Etiam sit amet porttitor erat. Nulla luctus metus quam, a congue augue congue et. Donec venenatis dui eget mauris ultrices, eu consequat ante consequat. Donec interdum nec velit a semper. Donec quis nulla sed libero ultricies congue nec in urna. Maecenas consectetur tellus elit, eget accumsan massa fringilla nec. Donec vestibulum, mauris id ornare dictum, magna metus congue metus", isPinned : true)
        let pulseTwo = Pulse(title: "The Road Ahead", author: "Evan Spiegel", description: " porttitor erat. Nulla luctus metus quam, a congue augue congue et. Donec venenatis dui eget mauris ultrices, eu consequat ante consequat. Donec interdum nec velit a semper. Donec quis nulla sed libero ultricies congue nec in urna. Maecenas consectetur tellus elit, eget accumsan massa fringilla nec. Donec vestibulum, mauris id ornare dictum, magna", isPinned: true)
        let pulseThree = Pulse(title: "Bounce house? Yes.", author: "Gary Vee", description: "sit amet, consectetur adipiscing elit. Proin iaculis nisl sagittis augue viverra facilisis. Etiam sit amet porttitor erat. Nulla luctus metus quam, a congue augue congue et. Donec venenatis dui eget mauris ultrices, eu consequat ante consequat. Donec interdum nec velit a semper. Donec quis nulla sed libero ", isPinned: true)
        self.pulses.append(pulseOne)
        self.pulses.append(pulseTwo)
        self.pulses.append(pulseThree)

    }
    
    func generateEventData() {
        let eventOne = Event(name: "Soccer", location: "Miami", image: UIImage(named:"soccer.png")!)
        let eventTwo = Event(name: "Yogaa", location: "South Beach", image: UIImage(named:"yoga.png")!)
        let eventThree = Event(name: "Dinner!!", location: "Fridays", image: UIImage(named:"dinner.png")!)
         let eventFour = Event(name: "Beach Day", location: "South Beach", image: UIImage(named:"beach.png")!)
        self.events.append(eventOne)
        self.events.append(eventTwo)
        self.events.append(eventThree)
        self.events.append(eventFour)

    }
    
    
    
}

extension PulseNewsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pulses.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PulseCell", for: indexPath) as! PulseTableViewCell
        cell.selectionStyle = .none

        cell.pinnedLbl.layer.borderWidth = 1.0
        cell.pinnedLbl.layer.borderColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1).cgColor
        cell.pinnedLbl.layer.cornerRadius = 5.0
        let pulse = pulses[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let dateString = dateFormatter.string(from: pulse.date)
        cell.titleLbl.text = pulse.title
        cell.dateAuthorLbl.text = "\(dateString) - \(pulse.author)"
        cell.descriptionLbl.text = pulse.description
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        let pulse = pulses[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popUpVC = storyboard.instantiateViewController(
            withIdentifier: "PopupViewController") as! PopupViewController
        popUpVC.modalPresentationStyle = .popover
        popUpVC.pulseTitle = pulse.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let dateString = dateFormatter.string(from: pulse.date)
        popUpVC.dateAuthor = "\(dateString) - \(pulse.author)"
        popUpVC.pulseDescription = pulse.description
        popUpVC.popoverPresentationController?.sourceRect = collectionView.frame
        
        // Present the view controller (in a popover).
        self.present(popUpVC, animated: true) {
            // The popover is visible.
        }
    }
    
}

extension PulseNewsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCollectionCell
        let event = events[indexPath.row]
        cell.eventNameLbl.text = event.name
        cell.layer.cornerRadius = 6.0
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: -5, height: 2)
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 0.3
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let dateString = dateFormatter.string(from: event.date)
        cell.eventDateLbl.text = dateString
        
        cell.eventLocationLbl.text = event.location
        cell.image.image = event.image
        
        return cell
    }
    
    
    
    
    
    
    
    
}
