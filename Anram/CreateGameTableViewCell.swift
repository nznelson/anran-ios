//
//  CreateGameTableViewCell.swift
//  Anram
//
//  Created by Nelson Shaw on 8/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import UIKit

class CreateGameTableViewCell: UITableViewCell {

    @IBOutlet weak var countText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func plusPressed(sender: AnyObject) {
        countText.text = String(countText.text!.toInt()! + 1)
    }
    
    @IBAction func minusPressed(sender: AnyObject) {
        countText.text = String(max(countText.text!.toInt()! - 1, 1))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
