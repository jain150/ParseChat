//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Arnav Jain on 2/23/17.
//  Copyright © 2017 Arnav Jain. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        var user = PFUser()
        user.username = loginTextField.text!
        user.password = passwordTextField.text!
        user.email = loginTextField.text!
        // other fields can be set just like with PFObject
        
        user.signUpInBackground(block: { (result, error) in
            if let error = error {
                
                //Showing error
                let alertController = UIAlertController(title: "Error", message: "Sign Up Unsuccesful", preferredStyle: .alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                
                let alertController = UIAlertController(title: "Success!", message: "Sign Up Successfull", preferredStyle: .alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                
            }
        })

    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let username = loginTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user: PFUser?, error: Error?) -> Void in
            if let error = error {
                if ((error as NSError).userInfo["error"] as? String) != nil {
                    let alert = UIAlertController(title: "Error", message: "Error Loging In!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                // Hooray! Let them use the app now.
                NSLog("Logged in!");
                self.performSegue(withIdentifier: "whenLoggedIn", sender: self)
            }
        }
        
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
