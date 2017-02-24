//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Arnav Jain on 2/23/17.
//  Copyright © 2017 Arnav Jain. All rights reserved.
//

import UIKit
import Parse
class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var textView: UITextField!
    
    var messages: [PFObject] = []

    @IBOutlet weak var tableview: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = 120
        tableview.rowHeight = UITableViewAutomaticDimension
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    func onTimer() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "chatViewCell", for: indexPath)
        let message = self.messages[indexPath.row]
        let text = message["text"] as? String
        if (message["username"] != nil) {
            cell.useremail.text = message["username"] as? String
        }
        
        
        cell.messageLabel?.text = text
        return cell
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        var message = PFObject(className: "Message")
        message["username"] = PFUser.current()?.username
        message["text"] = self.textView.text
        message.saveInBackground { (success, error) in
            if (success) {
                // The object has been saved.
            } else {
                
            }
        }
        self.textView.text = ""
        self.view.endEditing(true)
    }
    
    func getParseMessage() {
        let query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                print("Successfully retrieved \(objects?.count) objects.")
                
                if let message_objects = objects {
                    self.messages = message_objects
                    self.tableview.reloadData()
                }
            } else {
                print("error with finding objects")
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
