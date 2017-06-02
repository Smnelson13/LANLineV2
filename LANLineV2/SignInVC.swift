//
//  SignInVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK
import SVProgressHUD

class Session
{
  static let shared = Session()
  var user: SBDUser?
}

let kUsername = "LANLineV2.keys.username"

class SignInVC: UIViewController, UITextFieldDelegate
{
  @IBOutlet weak var connectButton: UIButton!
  var apiController: APIController!
  @IBOutlet weak var userIdTextField: UITextField!
  override func viewDidLoad()
  {
    super.viewDidLoad()
    userIdTextField.text = UserDefaults.standard.string(forKey: kUsername)
    userIdTextField.tintColor = UIColor.primaryPurple
    connectButton.layer.cornerRadius = 4
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
  }
  
  @IBAction func connectButtonTapped(_ sender: Any)
  {
    loggingIn()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    loggingIn()
    return false
  }

  func loggingIn()
  {
    if let text = userIdTextField.text
    {
      SVProgressHUD.show(withStatus: "Logging in...")
      SBDMain.connect(withUserId: text, completionHandler: { (user, error) in
        let success = (user != nil)
        
        UserDefaults.standard.set(text, forKey: kUsername)
        
        if success {
          SVProgressHUD.showSuccess(withStatus: "Logged in!")
        } else {
          SVProgressHUD.showError(withStatus: error.debugDescription)
        }
        
        SVProgressHUD.dismiss(after: 1) {
          
          if success
          {
            Session.shared.user = user
            self.performSegue(withIdentifier: "signInSegue", sender: nil)
          }
        }
      })
    }
  }

}
