//
//  PlayGameViewController.swift
//  Anram
//
//  Created by Nelson Shaw on 9/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {

    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var player2: UILabel!
    @IBOutlet weak var player1: UILabel!
    @IBOutlet weak var moveButton: UIButton!
    var pilePosEdit: Int!
    var taken: Int!
    
    @IBOutlet weak var tableView: UITableView!
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //        tableView.rowHeight = 200
        
        //refresh stuff
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading game")
        
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        self.taken = 0
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.doMoveButton()
        self.updateStatusView()
    }
    
    func doMoveButton(){
        if (game?.moves?.last?.player?.username! == UserStore.userName){
            moveButton.setTitle("Wait Your Turn", forState: .Normal)
            moveButton.backgroundColor = UIColor.redColor()
        } else {
            moveButton.setTitle("Make Move", forState: .Normal)
            moveButton.backgroundColor = UIColor.greenColor()
        }
        
    }
    
    func updateStatusView(){
        player1.text = game?.players![0].username
        joinButton.hidden = true
        player2.hidden = true
        if (game?.players!.count > 1){
            player2.text = game?.players![1].username
            player2.hidden = false
        } else if (game?.players![0].username != UserStore.userName) {
            //then you can join
            joinButton.hidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(sender:AnyObject)
    {
        // Code to refresh table view
        println("resfreshing here")
        getGame(self.game!.id!){ game in
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
            self.doMoveButton()
            self.updateStatusView()
        }
        
    }
    
    func getGame(game_id: Int, onComplete: ((game: Game?) -> Void)){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // make call
            API.sharedInstance.getGame(game_id){ newGame, statusCode,  error in
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if (statusCode == 401){
                        //unauth
                        appDel.showLogin()
                    } else if (statusCode == 500){
                        let alert = UIAlertController(title: "Ooops", message: "There was an error fetching game, please restart the app", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    } else {
                        
                        self.game = newGame
                    }
                    onComplete(game: newGame)
                    
                })
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
    @IBAction func didHitJoin(sender: AnyObject) {
        let spinner = addSpinnerAndStall()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // make call
            API.sharedInstance.joinGame(self.game!.id!){ newGames, statusCode,  error in
                dispatch_async(dispatch_get_main_queue(), {
                    self.bringAliveAndRemove(spinner)
                    if (statusCode == 401){
                        //unauth
                        appDel.showLogin()
                    } else if (statusCode == 500){
                        let alert = UIAlertController(title: "Ooops", message: "There was an joining this game", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                        //                        self.presentViewController(alert, animated: true, completion: nil)
                    } else {
                        //
                        self.updateStatusView()
                    }
                    
                })
            }
        })
    }
    
    @IBAction func didHitMove(sender: AnyObject) {
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // make call
            if (self.pilePosEdit == nil){
                //alert to say you need to update a pile
            } else {
                API.sharedInstance.makeMove(self.game!.id!, pile: self.pilePosEdit, taken: self.taken){ newGame, statusCode, error in
                
                  if (statusCode == 401){
                    //unauth
                      appDel.showLogin()
                  } else if (statusCode == 500){
                      let alert = UIAlertController(title: "Ooops", message: "There was an error making a move, please try again", preferredStyle: .Alert)
                      alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                      self.presentViewController(alert, animated: true, completion: nil)
                  } else {
                      self.game = newGame
                      self.doMoveButton()
                      self.tableView.reloadData()
                      self.taken = 0
                  }
              }
            }
        })
    }
    
    
}

extension PlayGameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game?.piles?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playCell", forIndexPath: indexPath) as! PlayGameTableViewCell
        let pile: Pile = game!.piles![indexPath.row]
        cell.pile = pile.position!
        cell.vcRef = self
        cell.amountLabel.text = String(pile.amount!)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 44
    }
 
}
