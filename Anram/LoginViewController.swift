//
//  LoginViewController.swift
//  Anram
//
//  Created by Nelson Shaw on 8/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var showLogin = false
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (!showLogin){
            loginButton.setTitle("Sign Up", forState: .Normal)
            loginButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            loginButton.backgroundColor = UIColor.whiteColor()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPushed(sender: AnyObject) {
        let spinner = addSpinnerAndStall()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // make call to auto app server with code
            
            
            if (self.showLogin){
                API.sharedInstance.login(self.username.text!, password: self.password.text) {user, statusCode, error in
                    println("callback")
                    self.bringAliveAndRemove(spinner)
                
                    if (statusCode == 401){
                        appDel.showLogin()
                    }
                    
                    else if (statusCode == 500){
                       let alert = UIAlertController(title: "Ooops", message: "There was an error logging in,  please try again", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    } else {
                       UserStore.userName = user!.username
                       appDel.showMain()
                   }
                
               }
            } else {
                API.sharedInstance.signUp(self.username.text!, password: self.password.text) {user, statusCode, error in
                    println("callback signup")
                    self.bringAliveAndRemove(spinner)
                    
                    if (statusCode == 500){
                        let alert = UIAlertController(title: "Ooops", message: "There was an error signing up,  please try again", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    } else {
                        UserStore.userName = user!.username
                        appDel.showMain()
                    }
                }
            }
        })
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
