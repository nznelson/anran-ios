//
//  PlayGameTableViewCell.swift
//  Anram
//
//  Created by Nelson Shaw on 9/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import UIKit

class PlayGameTableViewCell: UITableViewCell {

    var vcRef: PlayGameViewController!
    var taken: Int = 0
    var initialAmount: Int = 0
    var pile: Int = 0
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var minsPressed: UIButton!
    
    @IBAction func minusPressed(sender: AnyObject) {
        amountLabel.text = String(max(amountLabel.text!.toInt()! - 1, 0))
        vcRef.taken = vcRef.taken + 1
        vcRef.pilePosEdit = pile
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
