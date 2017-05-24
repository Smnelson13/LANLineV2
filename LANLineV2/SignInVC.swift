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

class SignInVC: UIViewController, UITextFieldDelegate
{
  
  @IBOutlet weak var userIdTextField: UITextField!
  @IBOutlet weak var nicknameTextField: UITextField!
  
  @IBAction func disconnectButtonTapped(_ sender: Any)
  {
    SBDMain.disconnect(completionHandler:
      {
      // ...
    })
  }

  override func viewDidLoad()
  {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  @IBAction func connectButtonTapped(_ sender: Any)
  {
    if let text = userIdTextField.text
    {
      SVProgressHUD.show(withStatus: "Logging in...")
      SBDMain.connect(withUserId: text, completionHandler: { (user, error) in
        let success = (user != nil)
        
        if success {
          SVProgressHUD.showSuccess(withStatus: "Logged in!")
        } else {
          SVProgressHUD.showError(withStatus: error.debugDescription)
        }
        
        SVProgressHUD.dismiss(after: 1) {
          
          if success
          {
            self.performSegue(withIdentifier: "signInSegue", sender: nil)
          }
        }
      })
    }
  }



}
