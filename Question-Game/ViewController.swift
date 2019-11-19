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

class ViewController: UIViewController {
    
    var questionsArray : [Question] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionsArray = preLoadFromPlist(forResource: "sheetData", ofType: "plist")
        
        for item in questionsArray
        {
            print(item)
        }
        // Do any additional setup after loading the view.
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
                     print("Key: \(locKey) - Value: \(locVal)")
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


}

