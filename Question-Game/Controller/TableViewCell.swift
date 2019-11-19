//
//  TableViewCell.swift
//  Question-Game
//
//  Created by Kapil Padaliya on 2019-11-18.
//  Copyright © 2019 Kapil Padaliya. All rights reserved.
//

import UIKit
protocol TableCellDelegate {
    func didTapOption(correctOption : Bool)
}

class TableViewCell: UITableViewCell {
    
    var question : Question = Question()
    
    var optionIndex : Int = 0
    
    var delegate : TableCellDelegate?


    @IBOutlet weak var optionButtonOutlet: UIButton!
    
    func checkIfThisIsACorrectOption() -> Bool
       {
           if(self.optionIndex == self.question.answerKey)
           {
               return true
           }
           return false
       }
    
    
   
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        
        print(self.optionIndex ,"Option number of Index that we provide")
        print(self.question.answerKey,"this is from the question object")
        print(self.checkIfThisIsACorrectOption())
        
            self.delegate?.didTapOption(correctOption: self.checkIfThisIsACorrectOption())
        
        if(self.checkIfThisIsACorrectOption())
               {
                   sender.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
               }
               else
        {sender.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            
        }
    }
    
    func setOption (optionText : String , optionIndex : Int)
        
    {
        self.optionButtonOutlet.backgroundColor = UIColor(named: "button2")
        self.optionButtonOutlet.setTitle(optionText,for: .normal)
        self.optionIndex = optionIndex
    
    
   

}
}
