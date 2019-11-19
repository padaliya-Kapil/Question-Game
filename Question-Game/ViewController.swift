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
   
    
    
    
    
    var questionsArray : [Question] = []
    var questionNumber = 0
    var currentQuestion : Question?
    var answerChosenForCurrentQuestion : Int?
    var selected5Questions : [Question] = []
    
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    @IBOutlet weak var optionsTableView: UITableView!
    
    //initial setup
    override func viewDidLoad() {
        super.viewDidLoad()
        //get data from plist
        self.questionsArray = preLoadFromPlist(forResource: "sheetData", ofType: "plist")
        

        self.set5SelectedQuestions()
        
        print(selected5Questions)
        
        self.currentQuestion = self.selected5Questions[0]
       
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        
    }
    
    // set 5 randomQuestions
    func set5SelectedQuestions()
    {
        for _ in 1...5
        {
            self.selected5Questions.append(self.questionsArray.randomElement()!)
        }
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        self.updateUI()
    }
    
    func updateUI()
    {
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()
                   + .milliseconds(800)) {
        print("ButtonPressed")
        self.optionsTableView.reloadData()
        print("Data reloaded")
        }
    }
    
    
    // pre-load data from plist for Books
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
        self.questionNumberLabel.text = "Question #CAl"
        self.currentQuestionLabel.text = self.currentQuestion?.question
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "tableCell") as! TableViewCell
        
        cell.setOption(optionText: (self.currentQuestion?.options[indexPath.row])!, optionIndex: indexPath.row)
        
        cell.delegate = self
        print(cell)
        return cell
    }
    
    func didTapOption(optionIndex: Int) {
    self.answerChosenForCurrentQuestion = optionIndex
        print(optionIndex)
       }


}

