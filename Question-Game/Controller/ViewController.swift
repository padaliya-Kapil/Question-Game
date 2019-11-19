//
//  ViewController.swift
//  Question-Game
//
//  Created by Kapil Padaliya on 2019-11-18.
//  Copyright © 2019 Kapil Padaliya. All rights reserved.
//

import UIKit

struct Question
{
    var question : String
    var options : [String]
    var answerKey : Int
    init()
    {
        self.question = ""
        self.options = []
        self.answerKey = 0
    }
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource , TableCellDelegate {
    @IBOutlet weak var progressView: UIProgressView!
    
    var questionsArray : [Question] = []
    var questionNumber = 0
    var currentQuestion : Question?
    var scoreTracker :[Int : Bool] = [:]
    
    
    var someThingSeletced : Bool = false
    var score = 0.0
    
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    @IBOutlet weak var optionsTableView: UITableView!
    
    //initial setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get data from plist
        self.questionsArray = preLoadFromPlist(forResource: "sheetData", ofType: "plist")
        self.currentQuestion = questionsArray.randomElement()
        
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        
        progressView.progress = 1/5.0
        
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if(self.someThingSeletced)
        {
            
            if(self.questionNumber < 4)
            {
                
                self.currentQuestion =  self.questionsArray.randomElement()
                self.updateUI()
                self.questionNumber += 1
                
            }else
            {
                
                self.performSegue(withIdentifier: "goToResult", sender: self)
                
            }
            
        }else
        {
            
            self.performSegue(withIdentifier: "goToError", sender: self)
        }
        
    }
    
    func updateUI()
    {
        
        self.progressView.progress = Float(self.questionNumber+2)/5.0
        self.optionsTableView.reloadData()
        self.someThingSeletced = false
    }
    func didTapOption(correctOption: Bool) {
          
        if(correctOption)
        {
            self.scoreTracker[self.questionNumber] = correctOption
        }
          self.someThingSeletced = true
      }
    
    
    // pre-load data from plist for Questions
    func preLoadFromPlist(forResource: String, ofType: String) -> [Question] {
        var preLoadcounter : Int = 0
        var localArray : [Question] = []
        
        // mak path from Plist File
        if let path = Bundle.main.path(forResource: forResource, ofType: ofType),
            
            // get dictionay via path
            let myDict = NSDictionary(contentsOfFile: path){
            
            //now start to Use myDict here
            //print(myDict["locations"])
            for (key, value) in (myDict["questions"] as? [String:Any])! {
                //print("For: \(key) ::")
                
                // here we are expecting LocationName , lat and lon
                var oneQuestion : Question = Question()
                for (locKey, locVal) in (value as? [String:Any])! {
                    //print("Key: \(locKey) - Value: \(locVal)")
                    switch locKey {
                    case "question":
                        oneQuestion.question = locVal as! String
                    case "options":
                        oneQuestion.options = locVal as! [String]
                    case "description":
                        oneQuestion.answerKey = locVal as! Int
                    default :
                        print("Not cool ")
                    }
                }
                // add conter in case of sucssesful save
                preLoadcounter += 1
                //print(oneBook)
                localArray.append(oneQuestion)
            }
        }
        return localArray
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.currentQuestion?.options.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "tableCell") as! TableViewCell
        
        cell.setOption(optionText: (self.currentQuestion?.options[indexPath.row])!, optionIndex: indexPath.row)
        
        cell.delegate = self
        cell.question = self.currentQuestion!
        
        self.questionNumberLabel.text = "Question \(self.questionNumber + 1)"
        
        self.currentQuestionLabel.text = self.currentQuestion?.question
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"
        {
            print("Going to Results")
            let segueDestination = segue.destination as! ResultViewController
            
            
            for (key,value) in self.scoreTracker
            {
                if(value)
                {
                    self.score += 1
                    print(key,value)
                }
            }
            
            segueDestination.score = self.score
        }
        //goToError
        if segue.identifier == "goToError"
        {
            let segueDestination = segue.destination as! ErrorViewController
            
        }
    }
    
    
}

