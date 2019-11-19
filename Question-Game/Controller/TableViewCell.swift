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
        delegate?.didTapOption(correctOption: self.checkIfThisIsACorrectOption())
    }
    
    func setOption (optionText : String , optionIndex : Int)
        
    {
        self.optionButtonOutlet.setTitle(optionText,for: .normal)
        self.optionIndex = optionIndex
    
    
   

}
}
