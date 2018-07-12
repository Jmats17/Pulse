//
//  QAViewController.swift
//  Pulse
//
//  Created by Justin Matsnev on 7/12/18.
//  Copyright © 2018 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit

class QAViewController : UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    var numVotes = 0
    var questions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        createMockQuestions()
    }
    
    func createMockQuestions() {
        let question = Question(question: "Does GE have a cryptocurrency?", answer: nil)
        let questionTwo = Question(question: "Is GE being sold to Github", answer: nil)
        let questionThree = Question(question: "GE acquiring Nestle for unlimited oreos?", answer: nil)
        questions.append(question)
        questions.append(questionTwo)
        questions.append(questionThree)

    }
    

    
    
}

extension QAViewController : UITableViewDelegate, UITableViewDataSource, QATableViewCellDelegate {
    
    func upVoteTapped(sender: QATableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let cell = tableView.dequeueReusableCell(withIdentifier: "QACell") as! QATableViewCell
        print("up tapped", sender, indexPath)
        let question = questions[indexPath.row]
        question.votes += 1
        print(question.votes)
       // cell.votesLabel.text = "\(question.votes)"
        tableView.reloadData()
        
    }
    
    func downVoteTapped(sender: QATableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        print("down tapped", sender, indexPath)
        let question = questions[indexPath.row]
        question.votes -= 1
        tableView.reloadData()

        print(question.votes)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QACell", for: indexPath) as! QATableViewCell
        cell.qaCellDelegate = self
        
        let question = questions[indexPath.row]
        
        cell.questionLabel.text = question.question
        cell.votesLabel.text = "\(question.votes)"
        return cell
    }
    
}
