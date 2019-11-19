//
//  ResultViewController.swift
//  Question-Game
//
//  Created by Kapil Padaliya on 2019-11-19.
//  Copyright © 2019 Kapil Padaliya. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var score : Double?
    override func viewDidLoad() {
        super.viewDidLoad()

        getLabelText(score: self.score!)
        print(score)
    }
    
    func getLabelText(score : Double) -> String
    {
        switch score {
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
    


}
