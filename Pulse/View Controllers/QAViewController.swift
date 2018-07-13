//
//  QAViewController.swift
//  Pulse
//
//  Created by Justin Matsnev on 7/12/18.
//  Copyright © 2018 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit
import PinterestSegment

class QAViewController : UIViewController {
    
    @IBOutlet weak var navBar : UINavigationBar!
    @IBOutlet weak var segmentView : UIView!
    @IBOutlet weak var tableView : UITableView!
    var numVotes = 0
    var questions = [Question]() {
        didSet {
            tableView.reloadData()
        }
    }
    var constantQuestions = [Question]()
    var segment : PinterestSegment!
    var filteredQuestions = [Question]()
    let filters = ["Most Recent","Most Popular","Engineering","Office", "Crypto", "Nerf", "Fun", "Design", "Serious", "Finance"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        createMockQuestions()
        addSegmentView()
        self.navBar.setBackgroundImage(UIImage(), for: .default)
        self.navBar.shadowImage = UIImage()
        self.navBar.isTranslucent = true
        checkValue()
        
    }
    
    func checkValue() {
        segment.valueChange = { index in
            switch self.filters[index] {
            case "Most Popular":
                self.questions = self.constantQuestions
                self.questions = self.questions.sorted(by: { $0.votes > $1.votes })
            case "Most Recent":
                self.questions = self.constantQuestions
                self.questions = self.questions.sorted(by: { $0.dateAdded > $1.dateAdded })
            case "Engineering":
                self.questions = self.constantQuestions
                self.questions = self.questions.filter{ ($0.tag?.contains("Engineering"))! }
                print(self.filteredQuestions.count)
            case "Office":
                self.questions = self.constantQuestions
                self.questions = self.questions.filter{ ($0.tag?.contains("Office"))! }
                print(self.filteredQuestions.count)
            case "Crypto":
                self.questions = self.constantQuestions
                self.questions = self.questions.filter{ ($0.tag?.contains("Crypto"))! }
                print(self.filteredQuestions.count)
            case "Nerf":
                self.questions = self.constantQuestions
                self.questions = self.questions.filter{ ($0.tag?.contains("Nerf"))! }
                print(self.filteredQuestions.count)
            case "Fun":
                self.questions = self.constantQuestions
                self.questions = self.questions.filter{ ($0.tag?.contains("Fun"))! }
                print(self.filteredQuestions.count)
            case "Design":
                self.questions = self.constantQuestions
                self.questions = self.questions.filter{ ($0.tag?.contains("Design"))! }
                print(self.filteredQuestions.count)
            case "Serious":
                self.questions = self.constantQuestions
                self.questions = self.questions.filter{ ($0.tag?.contains("Serious"))! }
                print(self.filteredQuestions.count)
            case "Finance":
                self.questions = self.constantQuestions
                self.questions = self.questions.filter{ ($0.tag?.contains("Finance"))! }
                print(self.filteredQuestions.count)
            default:
                break
            }
            self.tableView.reloadData()
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func addSegmentView() {
        var style = PinterestSegmentStyle()
        
        style.indicatorColor = UIColor(red: 223/255, green: 230/255, blue: 233/255, alpha: 0.5)
        style.titleMargin = 15
        style.titlePendingHorizontal = 14
        style.titlePendingVertical = 10
        style.titleFont = UIFont.systemFont(ofSize: 18, weight: .regular)
        style.normalTitleColor = UIColor(red: 99/255, green: 110/255, blue: 115/255, alpha: 0.5)
        style.selectedTitleColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1)
        segment = PinterestSegment(frame: CGRect(x: (segmentView.bounds.origin.x), y: (segmentView.bounds.origin.y / 2), width: segmentView.bounds.width, height: 40), titles: filters)
        segment.style = style
        self.segmentView.addSubview(segment)
    }
    
    func createMockQuestions() {
        let question = Question(question: "Does GE have a Cryptocurreny?", answer: "yes its called flannerycoin", tag: "Crypto")
        let questionTwo = Question(question: "Is GE being sold to Github", answer: nil, tag: "Finance")
        let questionThree = Question(question: "GE acquiring Nestle for unlimited oreos?", answer: nil, tag: "Serious")
        questions.append(question)
        questions.append(questionTwo)
        questions.append(questionThree)
        self.constantQuestions = self.questions
    }
    
    @IBAction func askQuestion(sender : UIButton) {
        let alert = UIAlertController(title: "Post a Question", message: "Please post a question you have below", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter your question here"
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter a tag"
        })
        let submit = UIAlertAction(title: "Submit", style: .default) { (action) in
            let questionTextfield = alert.textFields![0] as UITextField
            let tagTextfield = alert.textFields![1] as UITextField
            let question = Question(question: questionTextfield.text!, answer: nil, tag: tagTextfield.text!)
            self.questions.insert(question, at: 0)
            self.constantQuestions = self.questions
            self.tableView.reloadData()

        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alert.addAction(submit)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }

    
    
}

extension QAViewController : UITableViewDelegate, UITableViewDataSource, QATableViewCellDelegate {
    
    func upVoteTapped(sender: QATableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        print("up tapped", sender, indexPath)
        let question = questions[indexPath.row]
        question.votes += 1
        print(question.votes)
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

        return 126
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QACell", for: indexPath) as! QATableViewCell
        cell.qaCellDelegate = self
        
        let question = questions[indexPath.row]
        
        cell.questionLabel.text = question.question
        cell.votesLabel.text = "\(question.votes)"
        if question.votes > 0 {
            cell.votesLabel.textColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        }
        else if question.votes == 0 {
            cell.votesLabel.textColor = UIColor.black
        }
        else {
            cell.votesLabel.textColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
        }
        return cell
    }
    
}
