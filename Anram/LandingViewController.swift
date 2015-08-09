//
//  LandingViewController.swift
//  Anram
//
//  Created by Nelson Shaw on 9/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    var loginClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(sender: AnyObject) {
        self.loginClicked = true
        self.performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    
    @IBAction func signupPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if (segue.identifier == "loginSegue") {
            if let des = segue.destinationViewController as? LoginViewController {
                des.showLogin = self.loginClicked
            }
            
            //        if let des = segue.destinationViewController as? PlayGameViewController {
            //            des.game = setGame
            //        }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
