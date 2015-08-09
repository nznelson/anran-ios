//
//  CreateGameViewController.swift
//  Anram
//
//  Created by Nelson Shaw on 8/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import UIKit

class CreateGameViewController: UIViewController {

    @IBOutlet weak var cellCount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //        tableView.rowHeight = 200

        // Do any additional setup after loading the view.
    }
    
    @IBAction func plusPressed(sender: AnyObject) {
        cellCount.text = String(cellCount.text!.toInt()! + 1)
        self.tableView.reloadData()
    }
    
    @IBAction func minusPressed(sender: AnyObject) {
        cellCount.text = String(max(cellCount.text!.toInt()! - 1, 1))
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func didHitCreate(sender: AnyObject) {
        
        var counts = [Int]()
        
        for cell in self.tableView.visibleCells() {
            let c = cell as! CreateGameTableViewCell
            counts.append(c.countText.text!.toInt()!)
        }
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // make call
            
            API.sharedInstance.createGame(counts){ newRide, statusCode, error in
                
                if (statusCode == 401){
                    //unauth
                    appDel.showLogin()
                } else if (statusCode == 500){
                    let alert = UIAlertController(title: "Ooops", message: "There was an error creating this game, please try again", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                      self.performSegueWithIdentifier("unwindFromGame", sender: self)
                }
            }
        })
    }
    

}

extension CreateGameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount.text!.toInt()!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("createCell", forIndexPath: indexPath) as! CreateGameTableViewCell
//        cell.countText.text = "1"
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 44
    }
}
