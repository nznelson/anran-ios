//
//  MainTableViewCell.swift
//  Anram
//
//  Created by Nelson Shaw on 8/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var title: NSLayoutConstraint!
    
    var game: Game!
    
//    @IBAction func joinPressed(sender: AnyObject) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//            // make call
//            API.sharedInstance.joinGame(self.game.id!){ newGames, statusCode,  error in
//                dispatch_async(dispatch_get_main_queue(), {
//                    // set result of call to rides
//                    
//                    
//                    if (statusCode == 401){
//                        //unauth
//                        appDel.showLogin()
//                    } else if (statusCode == 500){
//                        let alert = UIAlertController(title: "Ooops", message: "There was an joining this game", preferredStyle: .Alert)
//                        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
////                        self.presentViewController(alert, animated: true, completion: nil)
//                    } else {
//                        //
//                    }
//                    
//                })
//            }
//        })
//    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
