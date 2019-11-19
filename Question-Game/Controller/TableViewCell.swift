//
//  TableViewCell.swift
//  Question-Game
//
//  Created by Kapil Padaliya on 2019-11-18.
//  Copyright © 2019 Kapil Padaliya. All rights reserved.
//

import UIKit
protocol TableCellDelegate {
    func didTapOption(optionIndex : Int)
}

class TableViewCell: UITableViewCell {
    
    var optionIndex : Int?
    
    var delegate : TableCellDelegate?


    @IBOutlet weak var optionButtonOutlet: UIButton!
   
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.didTapOption(optionIndex: self.optionIndex!)
    }
    
    func setOption (optionText : String , optionIndex : Int)
        
    {
        self.optionButtonOutlet.setTitle(optionText,for: .normal)
        self.optionIndex = optionIndex
    }

}
