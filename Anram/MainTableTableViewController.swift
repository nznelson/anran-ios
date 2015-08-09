//
//  MainTableTableViewController.swift
//  Anram
//
//  Created by Nelson Shaw on 8/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import UIKit

class MainTableTableViewController: UITableViewController {

    var games: Array<Game>? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var setGame: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)

        getGames(){ game in
            
        }
    }
    
    func refresh(sender:AnyObject)
    {
        // Code to refresh table view
        println("resfreshing here")
        getGames(){ game in
            self.refreshControl!.endRefreshing()
        }
        
    }
    

    func getGames(onComplete: ((games: Array<Game>?) -> Void)){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // make call
            API.sharedInstance.getGames(){ newGames, statusCode,  error in
                dispatch_async(dispatch_get_main_queue(), {
                    // set result of call to rides
                    
                    
                    if (statusCode == 401){
                        //unauth
                        appDel.showLogin()
                    } else if (statusCode == 500){
                        let alert = UIAlertController(title: "Ooops", message: "There was an error fetching your games, please restart the app", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    } else {
                        self.games = newGames
                        onComplete(games: newGames)
                    }
                    
                })
            }
        })
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return games?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gameCellId", forIndexPath: indexPath) as! MainTableViewCell
        let game = games![indexPath.row]
        var name: String = ""
        if (game.players?.count > 1){
            name = game.players![1].username!
        }
        cell.game = game
        
        switch indexPath.row % 3 {
        case 0:
            cell.backgroundColor = UIColor.blueColor()
        case 1:
            cell.backgroundColor = UIColor.purpleColor()
        case 2:
            cell.backgroundColor = UIColor.yellowColor()
        default:
            cell.backgroundColor = UIColor.blueColor()
        }
        
//        let two = game.players![1].username ?? ""
        let total = game.getRemainingAmounts()
        if (total == 0){
            cell.gameTitle.text = "Game \(game.id!) - \(game.moves!.last!.player!.username!) won!"
        } else {
            cell.gameTitle.text = "Game \(game.id!) - \(game.players![0].username!) vs \(name)"
        }
        
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //blah
        let game = games![indexPath.row]
        setGame = game
        self.performSegueWithIdentifier("playGameSegue", sender: self)
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if (segue.identifier == "playGameSegue") {
            let navController = segue.destinationViewController as! UINavigationController
            let detailController = navController.topViewController as! PlayGameViewController
            detailController.game = setGame
        }
        
//        if let des = segue.destinationViewController as? PlayGameViewController {
//            des.game = setGame
//        }
    }
    
    @IBAction func unwindToSegue (segue : UIStoryboardSegue) {}
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

