//
//  ResultViewController.swift
//  Question-Game
//
//  Created by Kapil Padaliya on 2019-11-19.
//  Copyright © 2019 Kapil Padaliya. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var scoreOutlet: UILabel!
    
    
    
    
    @IBOutlet weak var ResultextOutlet: UILabel!
    var score : Double?
    
    func calculateStars() -> String
    {
        var outString = ""
        if(self.score! == 0)
        {
            return "😔"
        }
        for _ in 1...Int(self.score!)
        {
            outString = outString + "⭐"
        }
        return outString
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scoreOutlet.text = calculateStars()
        self.ResultextOutlet.text = getLabelText()
        
        print(score)
    }
    
    func getLabelText() -> String
    {
        switch self.score! {
        case 0...2:
            return "Please try Again"
        case 3:
            return "Good job!"
        case 4:
            return "Excellent work!"
        default:
            return "You are a genius!"
        }
        
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
